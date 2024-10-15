// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract StateVariable {
    // 状态变量，不写修改此变量的方法，将会永远的保存在链上
    // 直到链消失
    uint public stateVariable = 123;

    function foo() external pure{
        // 在函数内部的局部变量，只有在函数被调用时，才会在虚拟机的内存中产生
        uint notStateVariable = 123;
    }

}