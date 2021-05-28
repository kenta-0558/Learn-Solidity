// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;


contract Storage {
    uint public val;
    
    constructor(uint _v) {
        val = _v;
    }
    
    function setValue(uint _v) external {
        val = _v;
    }
}

contract Machine {
    Storage public s;
    
    constructor(Storage _addr) {
        s = _addr;
    }
    
    function saveValue(uint _v) external returns (bool) {
        s.setValue(_v);
        return true;
    }
    
    function getValue() external view returns (uint) {
        return s.val();
    }
}