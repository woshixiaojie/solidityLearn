// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FunctionIntro {
    // external: 表示为外部可见
    // pure: 不对链上做任何操作
    function add (uint x, uint y) external pure  returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint){
        return x - y;
    }
}