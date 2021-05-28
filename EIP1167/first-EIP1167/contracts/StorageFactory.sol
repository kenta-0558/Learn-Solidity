pragma solidity ^0.8.3;

import "./Storage.sol";
import "./CloneFactory.sol";


contract StorageFactory is CloneFactory {
    address public admin;
    address public implementation;
    address[] public clonedContracts;

    constructor(address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }

    function createStorage() public {
        require(admin == msg.sender, "Only admin can clone contract");
        address clone = createClone(implementation);

        clonedContracts.push(clone);    
    }

    function getAddress(uint i) external view returns (address) {
        return clonedContracts[i];
    }
}