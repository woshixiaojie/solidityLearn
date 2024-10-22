// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; 

// Data Location - stroage, memory, celldate



contract DateLocations{
    struct MyStruct{
        uint number;
        string text;
    }

    mapping (address => MyStruct) public myStructs;


    // 函数入参，出参，为数组、结构体、字符串时，必须指明 memory 或 calldate
    function example(uint[] calldata _y, string memory _x, MyStruct memory _struct) external returns(uint[] memory _a) {
        myStructs[msg.sender] = MyStruct(123, "123");
        
        // 修改stroge的存储变量的值，会修改状态变量
        MyStruct storage myStruct1 = myStructs[msg.sender];
        myStruct1.number = 345;

        // 修改memory的存储变量的值，不会修改状态变量
        MyStruct memory myStruct2 = myStructs[msg.sender];
        myStruct2.text = "32132";

        // 函数内部调用其他函数，指明calldata入参，可以节省gas
        _internal(_y);

        uint[] memory a = new uint[](3);
        a[0] = 123;
        return a;
    }

    function _internal(uint[] calldata _y) public {
        //code
    }

}