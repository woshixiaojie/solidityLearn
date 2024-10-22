// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayShift {
    uint[] public arr;

    function example() external {
        arr = [1, 2, 3];
        delete arr[1];  // [1, 0, 3]
    }

    // [1, 2, 3, 4] -> arrayShift(2) -> [1, 2, 4]
    function arrayShift(uint _index) public {
        require(_index < arr.length, "_index out of bound");

        // Shift elements to the left
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }

        // Remove the last element
        arr.pop();
    }

    function test() external  {
        // Test case 1: [1, 2, 3, 4, 5] -> arrayShift(2) -> [1, 2, 4, 5]
        arr = [1, 2, 3, 4, 5];
        arrayShift(2);

        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5); 
        assert(arr.length == 4);

        // Test case 2: [1] -> arrayShift(0) -> []
        arr = [1];
        arrayShift(0);

        assert(arr.length == 0);
    }
}