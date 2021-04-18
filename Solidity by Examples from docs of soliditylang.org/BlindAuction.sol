// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract BlindAuction {
    
    struct Bid {
        bytes32 blindedBid;
        uint deposit;
    }

    address payable public beneficiary;
    uint public biddingEnd;
    uint public revealEnd;
    bool public ended;
    
    address public highestBidder;
    uint public highestBid;
    
    mapping(address => Bid[]) public bids;
    
    mapping(address => uint) pendingReturns;

    event AuctionEnded(address winner, uint highestBid);
}