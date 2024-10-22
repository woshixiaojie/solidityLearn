// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TestContrct {
    string public message;
    uint256 public x;

    event Log(string _message);

    // fallback() external payable {
    //     emit Log("fallback was called");
    // }

    function foo(string memory _message, uint256 _x)
        external
        payable
        returns (uint256, uint256)
    {
        message = _message;
        x = _x;
        return (x, 999);
    }
}

contract LowLevelCall {
    bytes public data;

    // 使用了主币，需要加上payable
    function fooCall(address _test) external payable  {
        // encodeWithSignature
        // 调用时入参uint，必须写成uint256
        // 参数的名称以及参数的存储都不需要写

        // "call foo", 123 为填入的参数

        // 返回值
        // 第一个返回是否成功，第二个为foo返回的所有数据

        // value: 123, gas: 5000 发送123个主币，5000个gas

        // foo有两个变量的运算，5000个gas不够，调用回报错
        // 同样调用如果不加上123个主币，也会报错
        (bool success, bytes memory _data) = _test.call{value: 123}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );
        require(success, "call failed");

        data = _data;
    }

    function callDoseNotExist(address _test) external  {
        (bool success, ) = _test.call(abi.encodeWithSignature("callDoseNotExist()"));
        require(success, "call failed");
    }
}
