// https://medium.com/coinmonks/solidity-who-the-heck-is-msg-sender-de68d3e98454

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract Storage {
    
    uint256 number;
    
    function store(uint256 _num) public {
        number = _num;
    }
    
    function retrieve() public view returns (uint256) {
        return number;
    }
    
    function inspectSender() public view returns (address) {
        return msg.sender;
    }
    
    function inspectOrigin() public view returns (address) {
        return tx.origin;
    }
}

contract Caller {
    
    Storage storageObject;
    
    constructor() {
        storageObject = new Storage();
    }
    
    function storageContractInspectSender() public view returns (address) {
        return storageObject.inspectSender();
    }
    
    function inspectSender() public view returns (address) {
        return msg.sender;
    }
    
    function torageContractInspectOrigin() public view returns (address) {
        return storageObject.inspectOrigin();
    }
}
