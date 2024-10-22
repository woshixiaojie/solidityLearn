// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

library Math {
    // 库合约定义外部可视，内部就无法使用。
    // 若想外部能用，定义公开可视
    // 若定义私有，则没有合约能使用，将会没有意义
    function max(uint256 _x, uint256 _y) internal pure returns (uint256) {
        // 三元写法
        return _x > _y ? _x : _y;
    }
}

contract Test {
    function testMax(uint256 _x, uint256 _y) external pure returns (uint256) {
        return Math.max(_x, _y);
    }
}

library ArrayFind {
    // 这里使用的是状态变量
    // 所以将参数存储位置定义在stroage上
    function find(uint256[] storage _arr, uint256 _x)
        internal
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < _arr.length; i++) {
            if (_arr[i] == _x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    // 将库的功能全部给uint[]这个类型
    using ArrayFind for uint256[];
    uint256[] public arr = [1, 2, 3, 4];

    function arrayFind() external view returns (uint256) {
        // return ArrayFind.find(arr, 3);

        // uint[]类型的变量，就能直接使用库里面的方法
        // 推荐之后使用这种
        return arr.find(3);

    }
}
