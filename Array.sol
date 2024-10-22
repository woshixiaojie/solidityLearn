// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Array {
    // 定义并初始化一个动态数组
    uint[] public nums = [1, 2, 3];
    // 定义并初始化一个定长数组
    uint[3] public numsFixed = [4, 5, 6];

    function example () external {
        // 使用下标获取数组的内容
        uint x = nums[1];
        uint y = numsFixed[1];

        // 使用delete不会删除数组元素
        // 只是将对应下标元素，初始化为对应元素零值
        delete nums[1]; // [1, 0, 3]
        delete numsFixed[1]; // [4, 0, 6]

        // 只有动态数组才能push 和pop
        nums.push(4); // [1, 2, 3, 4]
        nums.pop(); // [1, 2, 3]

        uint len = nums.length;

        // 在内存中创建数组
        // 必须是定长的
        uint[] memory a = new uint[](5);

    }

    // 从函数中返回整个数组，需要使用memory关键字
    function returnAllArray()external returns (uint[] memory) {
        return nums;
    }


}