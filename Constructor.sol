// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constructor{
    address public onwer;
    uint public x;

    // 构造函数，只会在合约部署时生效一次，一般用来初始化变量
    constructor (uint _x) {
        // 将部署者定义为owner
        onwer = msg.sender;
        // 将传入的_x赋值给x
        x = _x;
    }

}