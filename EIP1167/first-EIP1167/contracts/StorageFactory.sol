pragma solidity ^0.8.3;

import "./Storage.sol";
import "@optionality.io/clone-factory/contracts/CloneFactory.sol";

contract StorageFactory {
    address public admin;
    address public implementation;
    address[] public clonedContracts;
    
    function storageFactory(address _implementation) public {
        implementation = _implementation;
    }

    function createStorage() public {
        require(admin == msg.sedner, "Only admin can clone contract");
        address clone = createClone(implementation);

        clonedContracts.push(clone);    
    }

    function getAddress(uint i) external view returns (address) {
        return clonedContracts[i];
    }
}