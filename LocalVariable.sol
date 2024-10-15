// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 定义了三个状态变量
// 和两个局部变量
contract LocalVariable {
    uint public i;
    bool public b;
    address public addr;

    function foo() external  {
        uint x = 23;
        bool f = false;

        // 局部变量的值，不会落到链上
        x = 12;
        f = true;
        
        // 修改状态变量，会导致链的状态发生变化
        i = 222;
        b = true;
        addr  = address(1);
    }
}