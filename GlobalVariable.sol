// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GlobalVariable {
    // view: 表示只读方法，但是能读取全局变量和状态变量
    function globalVariable() external view returns (address, uint, uint) { // 函数的返回类型里，类型也得一致
        
        // msg.sender: 表示调用方，使用address存储
        // block.timestamp: 只读方法表示调用globalVariable方法的时间，写方法表示出块的时间
        // block.number：表示快号
        address sender =  msg.sender;
        uint timestamps =  block.timestamp;
        uint blockNum =  block.number;

        // 最后记得return对应的类型
        return (sender, timestamps, blockNum);
    }
}