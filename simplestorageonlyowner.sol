// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SimpleStorageOnlyOwner {
    uint storedData;
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function set(uint x) public onlyOwner {
        storedData = x;
    }
    
    function get() public view returns (uint) {
        return storedData;
    }
}