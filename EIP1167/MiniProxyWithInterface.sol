//https://medium.com/taipei-ethereum-meetup/reason-why-you-should-use-eip1167-proxy-contract-with-tutorial-cbb776d98e53
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;


abstract contract StorageInterface {
    function setName(string calldata name) external virtual;
    function getName() external virtual view returns (string memory);
}

contract Storage {
    string public name;
    
    function setName(string calldata _name) external {
        name = _name;
    }
    
    function getName() external view returns (string memory) {
        return name;
    }
}

contract StorageFactory {
    address template;
    
    address[] storages;
    
    constructor(address _template) {
        template = _template;
    }
    
    function create(string calldata _name) external returns (address)
    {
        address _storage = createClone(template);
        storages.push(_storage);
        StorageInterface(_storage).setName(_name);
        
        return _storage;
    }
    
    function getName(uint _index) external view returns (string memory) {
        return StorageInterface(storages[_index]).getName();
    }
    
    function createClone(address target) internal returns (address result) {
        bytes20 targetBytes = bytes20(target);
        assembly {
          let clone := mload(0x40)
          mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
          mstore(add(clone, 0x14), targetBytes)
          mstore(add(clone, 0x28), 0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000)
          result := create(0, clone, 0x37)
    }
  }
}