// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// 多签钱包
// 合约中，必须有多个人同意，才能将主币转出

contract MultiSignWallet {
    // 存款事件
    event Deposit(address indexed sender, uint256 amount);

    // 提交一个交易申请
    event Submit(uint256 indexed txId);

    // 合约中的签名人批准，可能有多个签名人，就需要多次批准
    event Approve(address indexed owner, uint256 txId);

    // 撤销，交易没有被执行前，可以撤销
    event Revoke(address indexed owner, uint256 indexed txId);

    // 执行，会讲合约中的主币，发送给另一个合约地址
    event Execute(uint256 indexed txId);

    // 合约的签名人，可能有多个人
    address[] public owners;

    // 在数组中找签名人，查找很耗费gas和事件，定义地址到bool的映射，帮助我们快速查找
    mapping(address => bool) public isOwner;

    // 确认数，不管有多少个签名人，只有瞒住确认数个签名人同意，才能批准
    uint256 public requireNum;

    // 交易结构体，保存每次对外发出的数据
    // 由一个签名人发起提议，由其他签名人同意批准
    struct Transaction {
        address to; // 发送的目标地址
        uint256 value; // 发送的主币数量
        bytes data; // 如果目标地址是合约地址，就可以执行合约里的函数
        bool executed; // 是够执行。执行后不能重复执行
    }

    // 记录所有的交易，该数组索引值就是交易号，即txId
    Transaction[] public transactions;

    // uint: transaction[]的索引，即交易号
    // address: 代表签名人地址
    // bool: 代表是否同意交易
    // 表示某次交易下，发起交易的签名人，是否批准了交易。只有这个签名人，执行了approve方法，才能是true
    mapping(uint256 => mapping(address => bool)) public approved;

    // 判断是否是签名人
    modifier OnlyOwner() {
        // 快速查找是够时owner，判断消息发送者是否在isOwner里
        require(isOwner[msg.sender], "not owner");
        _;
    }

    // 判断交易是否存在
    modifier txExists(uint256 _txId) {
        // 我们使用的数组索引作为交易号，所以判断交易号小于数组长度即可
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    // 判断交易是够被批准过
    modifier notApproved(uint256 _txId) {
        // 使用approved映射快速判断
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    // 判断交易是否被执行过
    modifier notExecuted(uint256 _txId) {
        //_txId表示的就是transactions数组的下标，所以可以很方便的查到，交易是否被执行了
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    // 地址数组作为参数必须指定存储位置
    constructor(address[] memory _owners, uint256 _requireNum) {
        // 若没有填入owner，那多签合约就失去了意义
        require(_owners.length > 0, "require owner");

        // 若requireNum小于0，那也没有意义
        // 若requireNum大于_owners.length，那合约永远不会被通过
        require(
            _requireNum > 0 && _requireNum <= _owners.length,
            "invaild required number of owners"
        );

        // 在将输入数组以及需要同意的人数，赋值给状态变量前
        // 需要检查数组中的地址，是否是0地址，以及是否重复添加过
        for (uint256 i = 0; i < _owners.length; i++) {
            require(_owners[i] != address(0), "invaild owner"); // 是否是0地址
            require(!isOwner[_owners[i]], "owner is not unique"); // 使用isOwner判断是否已经添加过该地址

            // 前置校验过后，将地址加入owners数组和isOwner中
            owners.push(_owners[i]);
            isOwner[_owners[i]] = true;
        }

        // 最后将确认数赋值，将输入变量，赋值给状态变量
        requireNum = _requireNum;
    }

    // 让合约能接收主币
    receive() external payable {
        // 记录谁发送给我们的,以及发送了多少
        emit Deposit(msg.sender, msg.value);
    }

    // 提交函数，创建交易结构体，并推入transactions数组
    // 只有签名人才能调用submit
    // address _to，发送交易的目标地址
    // uint _value，需要发多少主币
    // bytes calldata _data 以及额外参数，如果目标地址是合约地址，可以出发它的函数，将其存储设置为calldata
    function submit(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external OnlyOwner {
        // 将实例化结构体和推入数组，一步完成
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, executed: false})
        );

        // 触发交易的事件
        // 参数为交易id，由于上一步是推入一个元素到数组，所以此时交易id，就是数组长度-1
        emit Submit(transactions.length - 1);
    }

    // 批准函数
    // 当一个签名人提交了交易之后，其他签名人对这一次交易进行批准
    // 当达到最小确认交易数的时候，这个交易就能够被执行
    // 所以批准方法只能由签名人调用
    // 同时还要判断交易号是够存在，不存在则触发报错提醒
    // 以及是够已经批准过，若已经批准过，则触发报错提醒
    // 以及是够已经执行过，若已经执行过过，则触发报错提醒
    function approve(uint256 _txId)
        external
        OnlyOwner
        txExists(_txId)
        notApproved(_txId)
        notExecuted(_txId)
    {
        // 将记录批准的状态变量，txId对应谁为地址设置为true
        approved[_txId][msg.sender] = true;

        // 然后触发Approve事件
        emit Approve(msg.sender, _txId);
    }

    // 记录某个交易，有多少人批准了
    // 此函数只能内部合约使用，不希望被继承
    function _getApprovedCount(uint256 _txId)
        internal
        view
        returns (uint256 count)
    {
        // 遍历全部的签名人
        for (uint256 i = 0; i < owners.length; i++) {
            // 如果这次交易下，该签名人允许了，则count +1
            if (approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }

    // 执行
    function executed(uint256 _txId)
        external
        txExists(_txId)
        notExecuted(_txId)
    {
        // 执行前判断是否有主够的确认人数
        require(
            _getApprovedCount(_txId) >= requireNum,
            "approvals < requireNum"
        );

        // 声明storage的transaction，因为后面会更改他
        Transaction storage transaction = transactions[_txId];

        // 将执行状态设置为true
        transaction.executed = true;

        // 然后给目标地址转账
        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );

        require(success, "executed call failed");

        // 触发执行事件
        emit Execute(_txId);

    }

    // 撤销，在交易没有执行前，可以撤销
    function revoke(uint _txId) external OnlyOwner txExists(_txId) notExecuted(_txId) {
        // 检查交易，若没有被允许，则报错提示
        require(approved[_txId][msg.sender], "tx not approved");

        // 若被批准了，那就取消批准
        approved[_txId][msg.sender] = false;

        // 然后触发撤销事件
        emit Revoke(msg.sender, _txId);


    }
}
