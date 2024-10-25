// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


abstract contract Hello{
    function  a()  public virtual ;
}

contract World is Hello{
     function  a()  public override {
        
     } 
} 

contract A {
    // 使用virtual表明foo会被继承
    function foo() external pure virtual returns (string memory) {
        return "A";
    }

    function bar() external pure virtual returns (string memory) {
        return "A";
    }

    function baz() external pure returns (string memory) {
        return "A";
    }
}

// B继承与A
// B为子合约，A为父合约
contract B is A {
    // 使用override，表明foo被重写
    function foo() external pure override returns (string memory) {
        return "B";
    }

    // 被重写的代码，同样也可以被继承
    // 需指定 virtual override 关键字
    function bar() external pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is B{
    
    function bar() external pure override returns (string memory) {
        return "C";
    }

}
