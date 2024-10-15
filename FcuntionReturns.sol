// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FunctionReturns{
    // public：外部合约，以及合约内部都能调用
    // 返回多个值
    function returnMany()public pure returns (uint, bool) {
        return (1, false);
    }

    // 将返回值命名
    function returnNamed() public pure returns (uint x, bool b) {
        return (1, false);
    }

    // 指定返回值，可以不写return
    function assigned() public pure returns (uint x, bool b){
        x = 1;
        b = false;
    }

    // destructuring Assigment: 解析指定 - 就是怎么获取函数返回的多个值
    function destructuringAssigment() public pure {
        (uint x, bool b) = assigned();
        // 不需要时，记得使用逗号
        (, bool _b) = assigned();
    }

}