// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// immutable 可以不用一开始就定义
// 可以在部署的时候定义
contract Immutable {
    // 52562 gas 
    // address public owner = msg.sender;

    // 50111 gas
    // address public immutable owner = msg.sender;
    
    
    // 也可以选择这种写法
    // 消耗的gas一致
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    uint public x;
    function foo() external  {
        require(owner == msg.sender);
        x += 1;
    }

}