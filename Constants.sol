// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constants{
    // 常量就是一开始就知道的值，比如管理员地址，或者特殊编码
    // constant定义常量，不能被函数修改
    // 同时变量名大写，字母之间加上 '_'
    // 因为常量不需要修改，所以其他函数在调用时，可能没有gass或者gass很少
    address public constant MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint public MY_UINT = 123;

}

// 定义一个没有常量的合约
contract Var{
    address public MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}