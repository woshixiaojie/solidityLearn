// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Payable {
    // 定了payable的状态变量
    // 可以发送主币
    address payable public owner;

    constructor() {
        // msg.sender 没有payable属性，所以用下列表达式
        // 且此表达式只能写在构造函数中
        owner = payable(msg.sender);
    }

    // 定义了可以接受主币的方法
    // 不定义payable 发送主币会报错
    function deposite() external payable  {}


    function getBalance() external view returns (uint) {
        // 查看当前合约的余额
        return address(this).balance;
    }

}