// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    event Log(string _name);

    function foo() public  virtual {
        emit Log("A.foo");
    }

    function bar() public   virtual {
        emit Log("A.bar");
    }

}

contract B is A {

    function foo() public  virtual override  {
        emit Log("B.foo");
        // 直接指明调用的方法
        A.foo();
    }

    function bar() public   virtual override  {
        emit Log("B.bar");
        // super会去父合约，找方法调用
        super.bar();
    }
}

contract C is A {

    function foo() public  virtual override  {
        emit Log("C.foo");
        A.foo();
    }

    function bar() public   virtual override  {
        emit Log("C.bar");
        super.bar();
    }
}

contract D is B, C {
    // D.foo -> A.foo
    function foo() public  virtual override(B, C)  {
        emit Log("D.foo");
        A.foo();
    }

    // D.bar -> B.bar -> C.bar -> A.bar
    function bar() public   virtual override(B, C)  {
        emit Log("D.bar");
        super.bar();
    }
}