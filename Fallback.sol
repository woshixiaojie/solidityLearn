// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
Fallback executed when
- function don't exist
- directly send ETH
*/

contract Fallback{
    // 参数
    // 调用的方法名
    // 调用人
    // 发送的数目
    // 调用的数据
    event Log(string _callFuncionName, address _sender, uint count, bytes _data);
    
    // 加上payable才能发送接收主币
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
     }


}