// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract Factory {
    
    Child[] public children;
    
    event ChildCreated(uint date, uint data, address childAdress);
    
    function createChild(uint _data) external {
        Child child = new Child(_data);
        children.push(child);
        
        emit ChildCreated(block.timestamp, _data, address(child));
    }
    
}

contract Child {
    
    uint data;
    
    constructor(uint _data) {
        data = _data;
    }
}