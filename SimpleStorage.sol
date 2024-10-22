// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage{
    // 状态变量是公开可见，所以后自动有一个get方法
    string public text;

    // 函数入参名称前加上 _ 是为了 便于区分状态变量
    // memory 
    // gas	51939 gas
    // transaction cost	45164 gas 
    // execution cost	23644 gas 

    // calldata
    // gas	51409 gas
    // transaction cost	44703 gas 
    // execution cost	23183 gas 

    function setString(string calldata _text) external {
        text = _text;
    }

    // 此get方法为了是为了方便演示
    // 相当于是智能合约，将状态变量，拷贝到函数内存中，然后返回回来
    function getString() external view returns (string memory) {
        return text;
    }
}