// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Name {
    
    string myName;
    
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }
    
    function getMyName() public view returns (string memory) {
        return myName;
    }
    
    function setMyName(string memory _myName) public onlyOwner {
        myName = _myName;
    }
    
    function changeMyName(string memory _newMyName) public onlyOwner {
        myName = _newMyName;
    }
}