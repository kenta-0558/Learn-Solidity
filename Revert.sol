// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;


contract Revert {
    
    address owner;
    error Unauthorized();
    
    function buy(uint _amount) public payable {
        if (_amount > msg.value / 2 ether)
            revert("Not enough Ether provided");
            
        // require(_amount <= msg.value / 2 ether, "Not enough Ether provided");
    }
    
    function withdraw() public {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        
        payable(msg.sender).transfer(address(this).balance);
    }
}