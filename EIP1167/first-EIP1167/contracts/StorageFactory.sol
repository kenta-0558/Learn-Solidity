pragma solidity ^0.4.23;

import "./Storage.sol";
import "./CloneFactory.sol";


contract StorageFactory is CloneFactory {
    address public admin;
    address public implementation;
    address[] public clonedContracts;
    
    function storageFactory(address _implementation) public {
        implementation = _implementation;
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