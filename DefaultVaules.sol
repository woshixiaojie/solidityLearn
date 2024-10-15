// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DefaultVaules {
    bool public b; // false
    uint public u; // 0
    int public i; // 0
    address public addr; // 16进制表示，一共40个0：0x0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
                         // 以太坊中地址用160位表示
                         // 每个16进制用4位表示
                         // 40个16进制 = 160位

    bytes32 public b32; // 16进制表示，一共64个0 0x0000000000000000000000000000000000000000000000000000000000000000
                        // 1byte = 8 bits
                        // 1个16进制 为 4个bits表示
                        // 32bytes * 8bits = 1个16进制为4bits * 64bits
    
    // 以下内容后面会讲
    // mapping, structs, enums, fixed sized arrays(定长数组)
}