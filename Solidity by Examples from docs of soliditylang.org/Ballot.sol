//https://ethereum.stackexchange.com/questions/50310/how-to-pass-the-value-in-bytes32-array

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract Ballot {
    
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
    
    struct Proposal {
        bytes32 name;
        uint voteCount;
    }
    
    address public chairperson;
    
    mapping(address => Voter) public voters;
    
    Proposal[] public proposals;
    
    constructor(bytes32[] memory _proposalNames) {

        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint i = 0; i < _proposalNames.length; i++) {
            proposals.push(Proposal({
                name: _proposalNames[i],
                voteCount: 0
            }));
        }
    }
}