// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//hash特征
// 1、输入相同，输出一定相同
// 2、不同的值也会发生hash碰撞，只是几乎不可能
// 3、hash运算不可逆

contract HashOperation{
    // 返回定长的bytes可以不用加存储位置
    function hash(string memory y, uint x, address addr) external pure returns (bytes32) {
        // abi.encodePacked(y, x, addr) 打包成不定长的16进制
        // keccak256()对打包的16进制数字进行hash
       return keccak256(abi.encodePacked(y, x, addr));
    }

    // encode会对其补零
    function encode(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encode(text0, text1);
    }

    // encode会对其压缩，去掉0
    // 所以造成了，输入参数"123a","qwer" 与"123","aqwer" 打包的返回的值完全一致
    // 根据hash的特性，最后hash出来的值，也会一样
    function encodePacked(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encodePacked(text0, text1);
    }

    // 所以避免碰撞的方法是，中间加上参数，比如数字
    function collision(string memory text0, uint x, string memory text1) external pure returns (bytes32){
        return keccak256(abi.encodePacked(text0, x,text1));
    }

}