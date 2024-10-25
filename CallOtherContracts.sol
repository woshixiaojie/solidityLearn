// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CallTestContract{
    // 参数为调用合约的地址
    function setX(address _test, uint _x) external {
        // 然后以合约为类型调用函数
        TestContract(_test).setX(_x);

        OtherContract other = OtherContract(_test);
        
    }

    // 第二种写法就是直接以合约为类型
    // 由于getX是获取x的值，所以需要加上view和返回值
    function getX(TestContract _test) external view returns (uint) {
        // 然后直接调用
        return _test.getX();
    }

    // 使用了eth，所以需要加上payable
    function setXandReceiveEther(TestContract _test, uint _x) external payable  {
        // 同时把主币传递给调用的函数
        _test.setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(TestContract _test) external view returns (uint, uint){
        (uint x , uint value)  = _test.getXandValue();
        return (x, value);
    }

}


contract TestContract{
    uint public x;
    uint public value;

    function setX(uint _x) external  {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable  {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint ,uint)  {
        return (x, value);
    }

}