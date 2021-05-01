// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract EtherUnitsConverter {
    
    function convertToEther(uint _wei) public pure returns (uint _ether) {
        return _wei * 1e18;
    }
    
    function convertToGWei(uint _wei) public pure returns (uint _gWei) {
        return _wei * 1e9;
    }
    
    function convertToWei(uint _value) public pure returns (uint _wei) {
        return _value * 1;
    }
}