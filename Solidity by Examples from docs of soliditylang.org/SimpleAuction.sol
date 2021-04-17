// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract SimpleAuction {
    
    address payable public beneficiary;
    uint public auctionEndTime;
    
    address public highestBidder;
    uint public highestBid;

    bool ended;
    
    mapping(address => uint) pendingReturns;

    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);
}