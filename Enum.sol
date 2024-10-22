// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Enum{
    // 定义一个Status的enum
    // 枚举的值，是以索引的方式存在
    // 当一个变量有多个状态时，可以使用枚举enum
     enum Status {
        None,
        Pending,
        Shipping,
        Completed,
        Rejected,
        Canceled
     }


    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    function getEnum()external view returns (Status) {
        return status;
    }

    function setEnum(Status _status) external  {
        status = _status;
    }

    function setShipStatu() external {
        status = Status.Shipping;
    }

}