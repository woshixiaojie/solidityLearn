// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 继承顺序——最基本的继承顺序
// Order of inheritance - most base-lke to derived


contract A{
    function bar() external virtual pure returns (string memory) {
        return ("A");
    }

    function baz() external virtual pure returns (string memory) {
        return ("A");
    }

    function a() external  pure returns (string memory) {
        return ("A");
    }
}


contract B is A{
    function bar() external virtual override  pure returns (string memory) {
        return ("B");
    }

    function baz() external virtual override  pure returns (string memory) {
        return ("B");
    }

}

contract C is A, B{
    // 因为C继承了A和B，所以override也要指明A，B
    function bar() external  override(A, B)  pure returns (string memory) {
        return ("C");
    }

    function baz() external  override(A, B)  pure returns (string memory) {
        return ("C");
    }

}