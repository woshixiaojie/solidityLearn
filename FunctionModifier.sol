// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Function modifier, recuse code before and / or after function
// basic, input, sandwich

contract FunctionModifier {
    bool public paused;
    uint public count;

    function setPause(bool _paused) external {
        paused = _paused;

    }

    modifier whenNotPaused(){
        require(!paused, "paused");
        // _表示回到原来的函数运行
        _;
    }

    // 增加函数和减少函数，都有一段相同的代码
    // require(!paused, "paused");
    // 这时可以使用function modifier
    // 加入定义的whenNotPaused
    // 那函数在运行之前，会先进入函数修改器，遇到 _后，回到函数继续运行
    function inc() external whenNotPaused{
        // require(!paused, "paused");
        count += 1;
    }

    function dec() external whenNotPaused{
        // require(!paused, "paused");
        count -= 1;
    }

    // 定义了带输入参数_x的函数修改器
    modifier cap(uint _x){
        require(_x < 10, "x < 10");
        _;
    }

    // 下面两个函数，除了需要判断是否暂停
    // 还都判断了输入x的值
    // 这时可以使用带输入参数的修改器
    function incBy(uint _x) external whenNotPaused cap(_x){
        // require(!paused, "paused");
        // require(_x < 10, "x < 10");
        count += 1;
    }

    function decBy(uint _x)external whenNotPaused cap(_x) {
        // require(!paused, "paused");
        // require(_x < 10, "x < 10");
        count -= 1;
    }

    modifier sandwich(){
        count += 10;
        _;
        count -= 10;
    }
    // 相当于先进入修改器，运行count += 10;
    // 然后运行testSandwich函数中的，count += 1;
    // 最后再进人修改器，运行count -= 10;
    function testSandwich() external sandwich{
        count += 1;
    }

}