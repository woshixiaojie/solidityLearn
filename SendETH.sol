// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/* 
3 way to send ETH

transfer - 2300 gas, failed revert;
send - 2300 gas, return bool
call - all gas, returns bool and data

*/


contract SendETH{

    event Log(uint gas);

    // 两种可以接受主币的方法
    constructor() payable {}

    // 本次只接受主币，不发送数据
    // 使用receive
    receive() external payable { }


    function sendViaTransfer(address payable _to) external payable  {
        // 表示发送了123个wei
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable  {
       bool send =  _to.send(123);
       require(send, "send failed");
    }

    function sendViaCall(address payable _to) external payable  {
        (bool success, ) = _to.call{value: 12344454455}(""); // {value: } 表示发送的数量，("")表示发送的数据
        require(success, "call failed");
    }

}

contract ETHReceiver {
    // 接受的数量，和剩余的gas
    event Log(uint amount, uint gas);

    receive() external payable { 
        emit Log(msg.value, gasleft());
    }

}