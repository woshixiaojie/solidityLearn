// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 只需要一次操作，消耗的gas很小。
// 但是会打乱数组的顺序
contract ArrayReplace{
    uint[] public arr;

    // [1, 2, 3, 4] -> Replace(2) -> [1, 2, 4, 4] -> [1, 2, 4]
    // [1, 2, 4] -> replace(1) -> [1, 4, 4] -> [1, 4]

    function replace(uint _index) public  {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function testReplace() external  {
        arr = [1, 2, 3, 4];

        replace(2);
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);

        replace(1);
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
       
    }


}