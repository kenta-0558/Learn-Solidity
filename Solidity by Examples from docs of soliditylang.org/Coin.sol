// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    
    address public minter;
    mapping (address => uint) public balances;
    
    event Sent(address from, address to, uint amount);
    
    constructor() {
        minter = msg.sender;
    }
    
    function mint(address _receiver, uint _amount) public {
        require(minter == msg.sender, "you can not call this function");
        require(_amount < 1e60);
        balances[_receiver] += _amount;
    }
    
    function send(address _receiver, uint _amount) public {
        require(_amount <= balances[msg.sender], "your account does not habe enough balance");
        balances[msg.sender] -= _amount;
        balances[_receiver] += _amount;
        emit Sent(msg.sender, _receiver, _amount);
    }
}