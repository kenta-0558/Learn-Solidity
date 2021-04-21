// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract TicketAccessControl {
    
    address owner;
    
    modifier onlyOwner(address _owner) {
        require(owner == _owner, "");
        _;
    }
}


contract TicketBase is TicketAccessControl {
    
    struct Ticket {
        uint area;
        string ticketType;
        uint createdAt;
    }
    
    Ticket[] public tickets;
    
    mapping(uint => address) public ticketIndexToOwner;
    
    event IssueNewTicket(address owner, uint ticketID, uint createdAt);
    event CancelTicket(address owner, uint ticketID, uint canceledAt);

    function _transfer(uint _ticketID, address _owner, uint _createdAt) internal returns (uint) {

        ticketIndexToOwner[_ticketID] = _owner;
        
        emit IssueNewTicket(_owner, _ticketID, _createdAt);

        return _ticketID;
    }
    
    function _createTicket(uint _area, string memory _ticketType, address _owner) internal returns (uint _ticketID) {
        
        uint _createdAt = block.timestamp;
        
        tickets.push(Ticket({
            area: _area,
            ticketType: _ticketType,
            createdAt: _createdAt
        }));
        
        _ticketID = tickets.length - 1;
        
        _transfer(_ticketID, _owner, _createdAt);
    }
    
    function _deleteTicket(address _owner, uint _ticketID) external {
        
        require(ticketIndexToOwner[_ticketID] == _owner, "You gave wrong owner address or ticket ID!");
        
        delete tickets[_ticketID];
        
        emit CancelTicket(_owner, _ticketID, block.timestamp);
    } 
}


contract IssueVipTicket is TicketBase {
    
    uint constant VIP_TICKETS_LIMITS = 5;
    
    uint issuedTicketsCount;

    function createVipTicket(uint _area, string memory _ticketType, address _owner) public onlyOwner(msg.sender) {
        
        require(issuedTicketsCount <= 5, "You can not issue more VIP Ticket");
        
        _createTicket(_area, _ticketType, _owner);
        
        issuedTicketsCount++;
    }

    function giveVipTicket(uint _ticketID, address _newOwner) public onlyOwner(msg.sender) {
        
        uint _createdAt = block.timestamp;
        
        _transfer(_ticketID, _newOwner, _createdAt);
    }
    
}

contract TicketCore is IssueVipTicket {
    
    constructor() public {
        owner = msg.sender;
    }
    
}