// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ValueTypes {
    bool public b = true;

    uint public u = 123; // uint= uint256 0 to 2**256 - 1
                         // uint8  0 to 2**8 -1
                         // uint16 0 to 2**16 - 1

    int public i = -123; // int = int256 -2**255 to 2^255 -1
                         // int128 -2**127 to 2**127 -1

    // 获取int的最大最小值
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    // 下面的内容会面会说明
    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 ;
    bytes32 public b32 = 0x5B38Da6a701c568545dCfcB03FcB875f501c568545dCfcB03FcB875f56beddC4;

}








