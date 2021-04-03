// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.21 <0.9.0;

contract SendContract {
    
    address payable public richest;
    uint public mostSent;
    
    constructor() payable {
        richest = payable(msg.sender);
        mostSent = msg.value;
    }
    
    function becomeRichest() public payable {
        require(msg.value > mostSent, "money is not enough");
        
        richest.transfer(msg.value);
        
        richest = payable(msg.sender);
        mostSent = msg.value;
    }
}