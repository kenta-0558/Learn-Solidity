// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;



contract A {
    address addressB;
    
    function setAddressB(address _addressB) external {
        addressB = _addressB;
    }
    
    function getNameFromContractB() external view returns (string memory) {
        return B(addressB).getName();
    }
}

contract B {
    function getName() external pure returns (string memory) {
        return "Kiichi";
    }
}