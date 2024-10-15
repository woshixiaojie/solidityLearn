// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// require, revert, assert
// gas refund, state update are reverted
// custom error - save gas

contract Errors {
    function testRequire(uint _i) public pure {
        // 当_i <10,后面代码正常运行
        // 当_i >10,将会报出后面"_i > 10"报错信息
        require(_i <= 10, "_i > 10");
        // code
    }

    function testRevert(uint i)public pure  {
        if (i > 10){
            // revert与require相反
            // 当满足条件，则报"_i > 10"报错信息
            revert("i > 10");
        }
    }

    uint public num = 123;
    function testAssert() public view {
        // assert没有报错信息，只是用来断言
        assert(num == 123);
    }

    // 修改了状态变量，所以函数不能时view或者pure
    function gasRefund(uint _i) public {
        num += _i;
        // 如果_i不小于等于10，则前面运行的代码状态会被回滚，同时消耗的gas费也会被退回
        require(_i <= 10);
    }

    // 定义自定义错误
    error MyError(address, uint);
    function customError(uint _i) public view{
        // 如果打印的字符特别长，将会消耗更多的gas
        // require(_i < 10, "error, error, error, error, error, error.....");

        // 这时，可以使用自定义错误
        if (_i > 10){
            // 使用revert主动抛出错误
            revert MyError(msg.sender, _i);
        }
    }
}