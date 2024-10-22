// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Event{
    // 定义事件
    event Log(string message, uint val);

    // 也可以定义带索引的事件
    event IndexedLog(address indexed sender, uint val);

    function example() external  {
        // 触发事件
        emit Log("123", 1);

        // 触发事件，搜索事件时，可以根据sender过滤信息
        emit IndexedLog(msg.sender, 123);
    }

    event Message(address indexed _from, address indexed _to, string _message);

    function sendMessage(address _to, string calldata _message) external  {
        // 使用事件触发，比用状态变量触发，跟节省gas
        emit Message(msg.sender, _to, _message);
    }

}