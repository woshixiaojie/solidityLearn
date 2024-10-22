// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 继承的合约，构造函数有输入参数
contract A {
    constructor (string memory _name){

    }
}

contract B {
    constructor(string memory _name) {
        
    }
}

// 继承时传递参数
contract C is A("s"), B("s"){

}

// 部署时传递参数
contract D is A, B {
    constructor(string memory _text, string memory _name) A("s") B("s") {
        
    }
}

// 也可以将两者结合
contract E is A, B("s")  {
    constructor(string memory _text) A("s") {
        
    }
}


// F继承了A 和 B，他们都有构造函数
// 先运行的构造函数，取决于继承的顺序
// 比如下面的F is A, B
// 运行顺序就是 A，B，F
contract F is A, B {
    constructor(string memory _text, string memory _name) A("s") B("s") {
        
    }
}

// 构造函数的初始化顺序为 B, A, F
contract G is B, A {
    constructor(string memory _text, string memory _name) A("s") B("s") {
        
    }
}