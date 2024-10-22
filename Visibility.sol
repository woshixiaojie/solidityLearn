// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Visibility
// private - only inside contract
// internal - onli inside contract and child contracts
// public - inside and outside contract
// external - only from outside contract

contract A {
    uint private pri;
    uint internal inte;
    uint public pub;
    
    function priv() private pure {
        
    }

    function inter() internal pure {
        
    }

    function publ() public pure {
        
    }

    function exter() external pure {
        
    }

    function foo() external view {
        pri + inte + pub;

        priv();
        inter();
        publ();
    }

}

contract B is A {
    function foo1() external view  {
        inte + pub;

        inter();
        publ();

    }
}