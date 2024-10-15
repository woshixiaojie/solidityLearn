// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract ForAndWhileLoops{

    function loops () external pure {
        for ( uint i = 0; i < 10; i++){
            // code

            // 当i==3是，会跳过，后面的代码不会运行
            if (i == 3){
                continue;
            }
            // more code
            
            // 当i==5时，会跳出整个循环
            if (i == 5){
                break;
            }
            // more code
        }

        uint j = 0;    
        while (j < 10){
            // code
            j++;
        }

    }

    // 累加函数
    // 智能合约需要控制gass费，不能让_x太大，得控制循环的次数
    function sum(uint _x) external pure returns (uint){
        uint s;
        for (uint i = 1; i <= _x; i++){
            s += i;
        
        }
        return s;

    }

}