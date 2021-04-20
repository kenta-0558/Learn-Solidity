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
    
    function _createTicket(uint _area, string memory _ticketType) internal returns (uint _ticketID) {
        
        tickets.push(Ticket({
            area: _area,
            ticketType: _ticketType,
            createdAt: block.timestamp
        }));
        
        _ticketID = tickets.length - 1;
        
        ticketIndexToOwner[_ticketID] = msg.sender;
    }
}