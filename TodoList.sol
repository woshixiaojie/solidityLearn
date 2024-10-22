// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function createTodo(string calldata _text) external {
        todos.push(Todo({text: _text, completed: false}));
    }

    function updateTodoText(uint256 _i, string calldata _text) external {
        // 34606 gas
        todos[_i].text = _text;

        // 34621 gas
        // 下面消耗更多gas，因为占用了storage存储
        // Todo storage todo = todos[_i];
        // todo.text = _text;

        // 	38080 gas
        // 上面消耗的gas跟多，因为每次都需要把结构体，加载到内存中
        // todos[_i].text = _text;
        // todos[_i].text = _text;
        // todos[_i].text = _text;
        // todos[_i].text = _text;

        // 	37447 gas
        // Todo storage todo = todos[_i];
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;

        // 总结，
        // 如果只有一个数据需要更新，使用第一个
        // 如果有很多数据需要更新，使用第四个
    }

    function getTodo(uint256 _i) external view returns (string memory, bool) {
        // memory 8164 gas 直接读取的状态变量，只有一次拷贝，在函数返回时拷贝
        // storage 8082 gas 有两次拷贝，第一次从状态变量中拷贝到内存中读取，然后函数返回时再拷贝

        Todo storage todo = todos[_i]; 
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint _i) external {
        todos[_i].completed = !todos[_i].completed;
    }
}
