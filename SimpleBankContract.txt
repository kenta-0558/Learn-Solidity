// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.21 <0.9.0;


contract SimpleBank {
    
    mapping (address => uint) private balances;
    
    address public owner;
    
    event logDepositMade(address accoutAddress, uint amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    function deposit() public payable returns (uint) {
        
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        
        balances[msg.sender] += msg.value;
        
        emit logDepositMade(msg.sender, msg.value);
        
        return balances[msg.sender];        
    }
    
    function withdraw(uint withdrawAmount) public returns (uint) {
    
        require(balances[msg.sender] >= withdrawAmount);
        
        balances[msg.sender] -= withdrawAmount;
        
        payable(msg.sender).transfer(withdrawAmount);
        
        return balances[msg.sender];
    }
    
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
    
}