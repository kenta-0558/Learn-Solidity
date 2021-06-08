// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Test {
    
    function getHash(
        string memory _word,
        string memory _anotherWord
    )
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(_word, _anotherWord));
    }
    
}

contract Keccak256 {
    
    function getBool(string memory _word, string memory _anotherWord) external pure returns (bool) {
        bytes32 hash = 0x663fc72232e127e216084568d6af7a90734a0482463ea4fc10bd105cf840aeff;
        return hash == keccak256(abi.encodePacked(_word, _anotherWord));   
    }
    
}