// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// count能被两个函数操作
contract Counter {
    uint public count;

    // 函数指明external之后，表示只能被外部调用
    // 而不能被内部的函数调用
    function inc() external {
        count += 1;
    }

    function sub() external {
        count -= 1;
    }

}