// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract C {
    uint public immutable s = 123;
    
    constructor(){
        s = 345;
    }

    string immutable x1;
    address constant x6 = address(0);
    address immutable x7 = address(0);

    uint[] public arr;
    function f() public  {
        uint[2] memory arr1 = [uint(1), 2];
        arr = arr1;
        g([1, 2, 3]);
    }
    function g(uint8[3] memory _data) public pure {
        // ...
    }
}