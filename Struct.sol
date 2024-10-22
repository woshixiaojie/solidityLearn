// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Struct{
    // 定义一个Car结构体类型
    struct Car {
        string model;
        uint year;
        address owner;
    }

    // 声明一个Car类型的, car变量
    Car public car;

    // 声明一个Car[]类型的, cars类型数组
    Car[] public cars;
    mapping (address => Car[]) public carsByOwner;


    function example() external  {
        Car memory toyota = Car("Toyota", 1990, msg.sender);
        // 下面这种写法可以不要求顺序
        Car memory lambo = Car({year: 2000, model: "Lamborghini", owner: msg.sender});

        Car memory tesla;
        tesla.model = "model 3";
        tesla.year = 2020;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari", 2021, msg.sender));

        // 使用storage带有指针式的赋值
        // 可以修改状态变量
        Car storage _car = cars[0];
        _car.year = 2222;

        delete cars[1];

    }

}