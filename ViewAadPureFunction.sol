// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ViewAndPureFunction {
    uint public num;

    // 只要是使用了全局变量，或者状态变量，就得用view
    function viewFunction() external view returns (uint) {
        return num;
    }

    // 没有使用全局变量，或者状态变量
    // 或者只使用了局部变量，就用pure
    function pureFunction(uint x) external pure returns (uint) {
        return x;
    }

}