// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Test {
    
    function test(uint _number) external pure returns (uint result) {
        result = _number + 7;
    }  
    
    function test(uint _number1, uint _number2) external pure returns (uint result) {
        result = _number1 + _number2 + 7;
    }
    
    
    function test(uint _number1, uint _number2, uint _number3) external pure returns (uint result) {
        result = _number1 + _number2 + _number3 + 7;
    }
} 