// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccessControl {
    // 为了方便检索，加入了indexed
    event GrantRole(bytes32 indexed _role, address indexed _account);
    // 同样撤回也需要日志
    event RevokeRole(bytes32 indexed _role, address indexed _account);

    // 角色 -》账户地址 -〉是否有权限
    // role => address => bool

    // 角色名称使用bytes32存储，而不是字符串
    // 是因为字符串存储更消耗gas
    mapping(bytes32 => mapping(address => bool)) public roles;

    // 定义私有的可视范围，是不希望外部能获取变量的名称
    // 因为一开始设置为private会获取不到hash值
    // 那先设置public获取hash之后
    // 再设置private
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private USER = keccak256(abi.encodePacked("USER"));

    // 增加一个修改器
    // 来判断每次的调用者，是否有admin全新
    modifier OnlyAdmin(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    // 现在谁都没有ADMIN权限
    // 所以我们在部署时将部署者设置为ADMIN
    constructor() {
        // 这里直接使用内部函数，可以不用权限检测
        _grantRole(ADMIN, msg.sender);
    }

    // 定义内部可视，是希望继承的合约能使用，而外部不能使用
    function _grantRole(bytes32 _role, address _account) internal {
        // 将对应的value设置为true
        // 修改了状态变量，得有日志记录
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    // 提供给外部调用的函数
    // 必须使用内部函数来升级
    // 且调用者必须有ADMIN权限
    function grantRole(bytes32 _role, address _account)
        external
        OnlyAdmin(ADMIN)
    {
        _grantRole(_role, _account);
    }

    // 内部的撤销权限
    function _revokeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account)
        external
        OnlyAdmin(ADMIN)
    {
        _revokeRole(_role, _account);
    }
}
