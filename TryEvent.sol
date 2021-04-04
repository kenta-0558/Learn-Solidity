// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

// https://ethereum.org/ig/developers/tutorials/logging-events-smart-contracts/

contract Counter {
    
    event ValueChanged(uint oldValue, uint newValue);
    
    uint private count = 0;
    
    function increment() public {
        count += 1;
        emit ValueChanged(count - 1, count);
    }
    
    function getCount() public view returns (uint) {
        return count;
    }
}