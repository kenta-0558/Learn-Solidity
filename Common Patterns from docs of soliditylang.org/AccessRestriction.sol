// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.21 <0.9.0;

contract AccessRestriction {
    
    address public owner;
    uint public creationTime;
    
    constructor() {
        owner = msg.sender;
        creationTime = block.timestamp;
    }
    
    modifier onlyBy(address _account) {
        require(msg.sender == _account, "Sender not authorized");
        _;
    }
    
    function changeOwner(address _newOwner) public onlyBy(owner) {
        owner = _newOwner;
    }
    
    modifier onlyAfter(uint _time) {
        require(block.timestamp >= _time, "function called too early");
        _;
    }
    
    function disown() public onlyBy(owner) onlyAfter(creationTime + 1 minutes) {
        delete owner;
    }
    
    //i have to test these modifier and function with Remix.
    
    // modifier costs(uint _amount) {
    //     require(msg.value > _amount, "Please send more Ether");
    //     _;
    //     if (msg.value > _amount) {
    //         payable(msg.sender).transfer(msg.value - _amount);
    //     }
    // }
    
    // function forceOwnerChange(address _newOwner) public payable costs(200 ether) {
    //     owner = _newOwner;
    //     if (uint160(owner) & 0 == 1) 
    //         return;
    // }
    
}