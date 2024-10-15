// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract IfElseAndTernary {
    function example (uint _x) external pure returns (uint){
        if (_x < 10) {
            return 1;
        }else if (_x < 20){
            return 2;
        }else { // else也可以不写
            return 3;
        }
    }

    
    function ternary (uint _x) external pure returns (uint) {
        // if (_x < 10) {
        //     return 1;
        // }
        // return 2;
        // 三元表达式
        return _x < 10 ? 1 : 2;
    }
}