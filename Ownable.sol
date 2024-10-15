// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// state variable
// global variable
// midifier function
// constructor
// error handling
// function

// 合约中的账户管理系统
contract Ownable{
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner(){
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner)external  isOwner{
        // 判断调用者是不是owner，否则报错
        // 使用modifier function简化
        // require(msg.sender == owner, "not owner");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() external view isOwner{
        //code
    }

    function anyoneCanCallThisFunc()external {
        //code
    }
}
