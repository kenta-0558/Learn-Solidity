//https://forum.openzeppelin.com/t/function-settokenuri-in-erc721-is-gone-with-pragma-0-8-0/5978/3

//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
// import "https://github.com/itinance/openzeppelin-solidity/blob/master/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";


contract test is ERC721, Ownable {
    
    using Counters for Counters.Counter;
    Counters.Counter private tokenID;
    
    mapping (uint256 => string) public tokenURIs;

    constructor() ERC721("Kiichi", "KTT") {}  
    
    function awardItem(address _receiver, string memory _tokenURI) external onlyOwner returns (Counters.Counter memory) {
        
        require(_receiver != address(0));
        
        tokenID.increment();
        
        uint256 newTokenID = tokenID.current();
        _mint(_receiver, newTokenID);
        
        setTokenURI(newTokenID, _tokenURI);
        
        emit Transfer(address(0), _receiver, newTokenID);
        
        return tokenID;
    }
    
    function setTokenURI(uint256 _tokenID, string memory _tokentURI) private {
        tokenURIs[_tokenID] = _tokentURI;
    }
    
    function tokenURI(uint256 _tokenID) public view override returns (string memory) {
        require(_tokenID != 0, "There is such ID");
        return tokenURIs[_tokenID];
    }
    
} 