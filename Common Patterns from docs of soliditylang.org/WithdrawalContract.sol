// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.21 <0.9.0;


contract WithdrawalContract {
    
    address public richest;
    uint public mostSent;
    
    mapping (address => uint) pendingWithdrawals;
    
    constructor() payable {
        richest = msg.sender;
        mostSent = msg.value;
    }
    
    function becomeRichest() public payable {
        require(msg.value > mostSent, "Please send more money");
        
        pendingWithdrawals[richest] += msg.value;
        richest = msg.sender;
        mostSent = msg.value;
    }
    
    function Withdraw() public {
        uint amout = pendingWithdrawals[msg.sender];
        
        pendingWithdrawals[msg.sender] = 0;
        payable(msg.sender).transfer(amout);
    }
    
}