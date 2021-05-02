// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract DeleteInArrayInOrder {
    
    string[] public data;
    
    constructor() {
        data.push('Kiichi');    
        data.push('Ichina');    
        data.push('Kenta');    
        data.push('Yu-ta');    
        data.push('Yukina');    
    }
    
    function removeInOrder(uint _index) external {
        for (uint i = _index; i < data.length - 1; i++) {
            data[i] = data[i + 1];
        }
        data.pop();
    }
    
    function getData() external view returns (string[] memory) {
        return data;
    }
} 