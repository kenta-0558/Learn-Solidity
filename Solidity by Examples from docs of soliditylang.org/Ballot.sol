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

    function giveRightToVote(address _voter) public {
        
        require(chairperson == msg.sender, "You can not give right to vote");
        require(!voters[_voter].voted, "This voter already voted.");
        require(voters[_voter].weight == 0);
        
        voters[_voter].weight = 1;
    }

    function vote(uint _proposalIndex) public {
        
        Voter storage sender = voters[msg.sender];
        
        require(!sender.voted, "You have already voted");
        require(sender.weight != 0, "You do not have right to vote");
        
        sender.vote = _proposalIndex;
        sender.voted = true;
        
        proposals[_proposalIndex].voteCount += sender.weight; 
    }

    function getWinnerName() public view returns (bytes32 _winnerName) {
        
        uint winnerProposalIndex = getWinnerProposalIndex();
        
        _winnerName = proposals[winnerProposalIndex].name;
    }
    
    function getWinnerProposalIndex() internal view returns (uint _winnerProposalIndex) {
        
        uint winnerVoteCount = 0;
        
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winnerVoteCount) {
                winnerVoteCount = proposals[i].voteCount;
                _winnerProposalIndex = i;
            }    
        } 
    }

}