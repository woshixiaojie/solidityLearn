// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Account{
    address public bank;
    address public owner;

    constructor(address _owner) payable  {
        // 由工厂创建，所以地址也是工厂的地址
        bank = msg.sender;
        // 由工厂传入，所以是部署者的地址
        owner = _owner; 
    }

}

contract FactoryContractNew{
    // 同样我们可以创建一个账户合约地址
    // 记录所有以工厂模式创建的合约
    Account[] public accounts;

    // 此函数对应Account的构造函数
    // 由于构造函数是可以接受主币，所以得加上payable
    function createAcount(address _owner) external payable  {
        // 通过new创建合约

        // 和工厂合约在同一文件中，可以直接写名字，属于引用关系，不属于继承
        // 不在一个文件可以import

        // 然后传入构造函数的参数 _owner
        // 返回新创建合约的地址

        // 以账户合约名称为类型，创建一个account变量
        // {value: 111}就像合约调用call，传入gas
        Account account = new Account{value: 111}(_owner);

        // 将新建的合约推入数组
        accounts.push(account);
    }

}