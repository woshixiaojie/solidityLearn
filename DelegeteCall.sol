// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TestDelegateCallContract {
    // 被调用合约与调用合约
    // 需要改变状态的状态变量
    // 顺心必须一致
    uint256 public num;
    address public sender;
    uint256 public value;
    // 将这个owner变量接在，需要改变的变量下面可以
    // 但是中间和上面不行
    address public owner;

    function setVars(uint256 _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCallContract {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _num) external payable {
        // (bool success, bytes memory data) = _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint)", _num)
        // );

        // 上面这种写法也是转化成一个selector
        // 这种就是直接写
         (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCallContract.setVars.selector, _num)
        );

        require(success, "delegateCall failed");
    }
}
