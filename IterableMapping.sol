// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 数组可以遍历
// map可以快速找到元素
// 两则结合，可以实现迭代

contract IterableMapping {
    // 地址 -> 余额、地址是否存在、记录存在的地址的数组
    mapping (address => uint) public balances;
    mapping (address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint _value) external  {
        balances[_key] = _value;

        // 如果不存在，则将其插入insert和keys中
        if (!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view  returns (uint){
        return keys.length;
    }

    function getFirst()external view returns (uint) {
        return balances[keys[0]];
    }

    function getLast() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    // 获取任意账户的余额
    function fromIndexGet(uint _index) external view returns (uint){
        return balances[keys[_index]];
    }

    // 将getSize 和 fromeIndexGet 结合，可以遍历全部账户的余额

}