// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract AccessControl {
    
    address public presidentAddress;
    address public managerAddress;
    address public assistantAddress;
    address public player1Address;
    address public player2Address;
    
    bool public noTrainingAfterGame = false; 
    
    constructor() {
        presidentAddress = msg.sender;
    }
    
    modifier onlyPresident() {
        require(presidentAddress == msg.sender);
        _;
    }    
    
    modifier onlyManager() {
        require(managerAddress == msg.sender);
        _;
    }    
    
    modifier onlyAssistant() {
        require(assistantAddress == msg.sender);
        _;
    }
    
    modifier onlyManagementTeam() {
        require(
            managerAddress == msg.sender ||
            assistantAddress == msg.sender
        );
        _;
    }
    
    modifier onlyPlayer() {
        require(
            player1Address == msg.sender ||
            player2Address == msg.sender 
        );
        _;
    }
    
    function setManager(address _newManagerAddress) external onlyPresident {
        require(_newManagerAddress != address(0));
        
        managerAddress = _newManagerAddress;
    }
    
    function changePlayer1(address _newPlayerAddress) external onlyManager {
        require(_newPlayerAddress != address(0));
        
        player1Address = _newPlayerAddress;
    }
    
    modifier takeBreakAfterGame() {
        require(!noTrainingAfterGame);
        _;
    }
    
    function takeBreak() external onlyManagementTeam takeBreakAfterGame {
        noTrainingAfterGame= true;    
    }
    
}