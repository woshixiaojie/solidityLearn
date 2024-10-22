// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }
    
    // 接收主币的函数
    receive() external payable { }

    function withdraw(uint _amount) external payable   {
        require(msg.sender == owner, "caller is not owner");
        // 使用内存中的msg.sender，节约gas
        payable(msg.sender).transfer(_amount);

        // 使用call发送eth可以不用加上payable
        // (bool success, ) = msg.sender.call{value: _amount}("");
        // require(success, "call failed");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }


}