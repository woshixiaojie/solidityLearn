// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// ERC20标准合约，指的是只要满足了IERC20的借口，就是ERC20标准合约

interface IERC20 {
    // 代表当前合约token总量
    function totalSupply() external view returns (uint256);

    // 代表某一个账户的当前余额
    function balanceOf(address account) external view returns (uint256);

    // 把当前账户余额，由调用者发送到另一个账户中
    // 由于是写入方法，所以还会想链外上传一个Transfor事件
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    // approve允许之后，可以通过这个allowance查询一个账户对另外一个账户的批准余额
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    // 将账户中的余额，批准给另外一个账户
    function approve(address spender, uint256 amount) external returns (bool);

    // 我们向另一个合约存款的时候，另一个合约必须调用transforFrom
    // 才能将我们的token拿到他的合约中
    // 此方法与approve联合使用
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approve(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
}

// ERC20继承IERC20接口之后，需要实现IERC20所有的接口
contract ERC20 is IERC20 {
    // 公开可视的totalSupply变量自带getter函数，所以就是实现了totalSupply方法，同理下面的balanceOf变量
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    // allowance方法是要查询一个合约给另一个合约的批准的余额
    // 那就需要定义allowance地址到地址到数字的映射
    mapping(address => mapping(address => uint256)) _allowance;

    string public name = "Test"; // 定义ERC20的token名称，此处使用string类型
    string public symbol = "TEST"; // 定义ERC20的token缩写或者说符号，一般全部大写
    uint8 public decimals = 18; // 定义token进度，此处表示1后面跟18个0。智能合约中不能有小数，若有0.5个token，就是5后面跟17个0

    // 逻辑：发送者减少数量，接受者账户增加数量。不强制要求一样的逻辑
    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        // 前面若发生数学溢出，不会运行到这个返回
        return true;
    }

    function allowance(address owner, address spender)
        external
        view
        returns (uint256)
    {
        return _allowance[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        // 此处逻辑，可以是授权余额。也可以是设置为0，取消授权
        // 之后就可以从allowance映射中查询数量
        _allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    // 函数的调用者是approve中的被批准用户spender
    // 发送者是approve中批准的调用者
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        // 发送者，被批准账户，也就是当前的调用者，被批准额度，剪掉当前数量
        // 因为你已经接收到了，不能重复批准
        _allowance[sender][msg.sender] -= amount;

        // 从发送者剪掉余额，而不是调用者
        // 因为调用者，此时只是一个执行的身份
        balanceOf[sender] -= amount;

        // 给接受者增加额度
        balanceOf[recipient] += amount;

        // 触发转账事件，转账的不是消息调用者，而是发送者
        emit Transfer(sender, recipient, amount);

        return true;
    }

    // 现在有一个问题，没有任何一个人的账户中拥有余额
    // 所以得有一个给一个账户增加余额的方法
    // 一般情况下ERC20的token会在部署时，会通过构造函数把一个指定数目的余额，给当前账户的部署者
    // 此处通过一个简单的铸币方法给账户增加余额，我们并没有权限控制

    function mint(uint256 amount) external {
        // 给部署者增加余额
        balanceOf[msg.sender] += amount;
        // 同时给合约总量增加余额
        totalSupply += amount;

        // ERC20标准没有铸币事件，这里使用Transfer事件
        // 用0地址表示发送者，同时表示这个是一个铸币事件
        emit Transfer(address(0), msg.sender, amount);
    }

    // 还需要一个销毁币的事件，与铸币事件相反
    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
