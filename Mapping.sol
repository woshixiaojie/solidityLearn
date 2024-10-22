// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Mapping
// How to daclare a mapping (simple and nested)
// set get delete

// 判断jack是否在数组里，需要循环整个数组
// ['alice', 'bob', 'charlie']
// 而使用map找jack时。则会返回false。只需要一次操作
// {'alice': true, 'bob': true, 'charlie': true}

contract Mapping{
    // simple declare 
    // 地址 -> 余额，账本
    mapping (address => uint) public balances;

    // nested daclare
    mapping (address => mapping (address => bool)) public isFriend;

    function example() external  {
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];

        uint bal2 = balances[address(0)]; // 返回uint默认值0

        balances[msg.sender] += 456; // 123 + 456 = 579

        delete balances[msg.sender]; // 不会真实删除这个元素，只是将其value置为0

        // msg.sender表示调用者地址
        // address(this)表示当前合约的地址
        isFriend[msg.sender][address(this)] = false;

    }

}