// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 定义COunter合约的接口，一般在前面加I
interface ICounter{
    // Counter里面有public有count的状态变量，所以是有这个count方法的
    function count() external view returns (uint);
    function inc() external;

}

contract CallInterface{
    // Counter没在这个文件里，所以不能这样写
    // function simple(Counter _counter) external  {
    // }

    uint public count;

    function simple(address _counter) external {
        // 调用接口
        ICounter(_counter).inc();
        count =  ICounter(_counter).count();
    }

}

