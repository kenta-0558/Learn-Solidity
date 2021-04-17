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

    mapping(uint =>  Campaign) public campaigns;
    
    uint numCampaigns;

    function createNewCampaign(address payable _beneficiary, uint _fundingGoal) public returns (uint _campaignID) {
        _campaignID = numCampaigns++;
        Campaign storage newCampaign = campaigns[numCampaigns];
        newCampaign.beneficiary = _beneficiary;
        newCampaign.fundingGoal = _fundingGoal;
    }

    function contribute(uint _campaignID) public payable {
        
        Campaign storage selectedCampaign = campaigns[_campaignID];
        
        uint _numberFunders = selectedCampaign.numfunders++;
        selectedCampaign.funders[_numberFunders] = Funder({funderAddress: msg.sender, amount: msg.value});
        selectedCampaign.amount += msg.value;
    }


}