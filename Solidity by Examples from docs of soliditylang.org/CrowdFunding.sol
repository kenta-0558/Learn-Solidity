// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract CrowdFunding {
    
    struct Funder {
        address funderAddress;
        uint amount;
    }
    
    struct Campaign {
        address payable beneficiary;
        uint fundingGoal;
        uint numfunders;
        uint amount;
        mapping (uint => Funder) funders;
    }

    mapping(uint =>  Campaign) campaigns;
    
    uint numCampaings;
}