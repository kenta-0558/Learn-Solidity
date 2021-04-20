// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract TicketBase {
    
    struct Ticket {
        address owner;
        uint area;
        string durations;
        uint createdAt;
    }
    
    Ticket[] public tickets;
    
    mapping(uint => address) public ticketIndexToOwner;
}