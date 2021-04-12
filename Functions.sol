// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract FunctionTest {
    
    function calculationA(uint _a, uint _b) public pure returns (uint _sumA, uint _sumB) {
        
        require(_a > _b);
        
        _sumA = _a + _b;
        _sumB = _a  - _b;
    }   

    function calculationB(uint _a, uint _b) public pure returns (uint _sumA, uint _sumB) {
        require(_a > 0 && _b > 0);
        return (_a + _b, _a * _b);
    }
}