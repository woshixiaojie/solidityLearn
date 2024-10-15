//声明MIT的开源协议
// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7; // 声明使用0.8.7的solidity版本，^表示0.8.7以上但不包括0.9版本的都可以

contract HelloWorld{ // 定义一个HelloWorld的合约
    // string: 字符串变量
    // public: 表示公开的变量
    // string public myString: 自带一个只读的mystring方法
    string public myString = "hello world";
}

