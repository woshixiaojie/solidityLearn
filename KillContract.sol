// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// selfdestruct 触发自毁合约
// - delete contract 会删除合约，其内部方法也会无法调用 
// - force send ether to any address 如果有eth，会然后强制发送给其他地址，比如合约

contract Kill{
    // 以太坊升级cankun之后，selfdestruct只会在创建合约时执行，才会删除合约代码和数据
    // 创建一个用于接受主币的构造函数
    // constructor() payable {
    // // 在构造函数中直接调用kill，会删除合约代码和数据
    //     selfdestruct(payable(msg.sender));
    // }

    // // 创建一个用于接受主币的构造函数
    constructor() payable {}

    // 调用kill。会触发自毁合约，这是一种强制行为
    function kill() external  {
        // 发送主币给msg.sender
        // 由于发送主币需要payable，而msg.sender本身没有
        // 我们需要主动加上
        // 会转移合约中的以太币到msg.sender，不会删除合约代码和数据
        selfdestruct(payable(msg.sender));
    }

    // 测试函数，用于检测自毁之后，是否能调用
    function test() external pure returns (uint) {
        return 123;
    }

}

contract Helper{
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function callKill(Kill _kill) external  {
        _kill.kill();
    }

}

