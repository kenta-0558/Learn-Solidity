// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract CryptoPunksMarket {
    
    struct Offer {
        bool isForSale;
        uint punkIndex;
        address seller;
        uint minValue;
        address onlySellTo;
    }
    
    struct Bid {
        bool hasBid;
        uint punkIndex;
        address bidder;
        uint value;
    }
    
    mapping (uint => Offer) public punksOfferedForSale;
    mapping (uint => Bid) public punkBids;
    
    
    string public imageHash;
    address owner;
    string public standard = "CryptoPunks";
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    uint public nextPunkIndexToAssign = 0;
    
    bool public allPunksAssigned = false;
    uint public punksRemainingToAssign = 0;
    
    mapping (uint => address) public punkIndexToAddress;
    
    mapping (address => uint256) public balanceOf;
    
    mapping (address => uint) public pendingWithdrawals;

    event Assign(address indexed to, uint256 punkIndex);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event PunkTransfer(address indexed from, address indexed to, uint256 punkIndex);
    event PunkOffered(uint indexed punkIndex, uint minValue, address indexed toAddress);
    event PunkBidEntered(uint indexed punkIndex, uint value, address indexed fromAddress);
    event PunkBidWithdrawn(uint indexed punkIndex, uint value, address indexed fromAddress);
    event PunkBought(uint indexed punkIndex, uint value, address indexed fromAddress, address indexed toAddress);
    event PunkNoLongerForSale(uint indexed punkIndex);
    
    // why payable ???
     // why not with constructor ???
    function initializeCryptoPunksMarket() public payable {
        
        owner = msg.sender;
        totalSupply = 10000;
        punksRemainingToAssign = totalSupply;
        name = "CRYPTOPUNKS";
        // symbol = "[]";
        decimals = 0;
    }

}