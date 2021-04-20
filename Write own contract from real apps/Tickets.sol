// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract TicketBase {
    
    struct Ticket {
        uint area;
        string ticketType;
        uint createdAt;
    }
    
    Ticket[] public tickets;
    
    mapping(uint => address) public ticketIndexToOwner;
    
    event IssueNewTicket(address owner, uint ticketID, uint createdAt);
    event CancelTicket(address owner, uint ticketID, uint canceledAt);
    
    function _createTicket(uint _area, string memory _ticketType, address _owner) internal returns (uint _ticketID) {
        
        uint _createdAt = block.timestamp;
        
        tickets.push(Ticket({
            area: _area,
            ticketType: _ticketType,
            createdAt: _createdAt
        }));
        
        _ticketID = tickets.length - 1;
        
        ticketIndexToOwner[_ticketID] = _owner;
        
        emit IssueNewTicket(_owner, _ticketID, _createdAt);
    }
    
    function _deleteTicket(address _owner, uint _ticketID) external {
        
        require(ticketIndexToOwner[_ticketID] == _owner, "You gave wrong owner address or ticket ID!");
        
        delete tickets[_ticketID];
        
        CancelTicket(_owner, _ticketID, block.timestamp);
    } 
}