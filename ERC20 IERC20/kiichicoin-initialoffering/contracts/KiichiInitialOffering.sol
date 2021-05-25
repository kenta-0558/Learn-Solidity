// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract KiichiInitialOffering is Ownable {

    using SafeERC20 for IERC20;
    using SafeMath for uint;

    uint public constant START = 1625832000; // Time Zone GMT
    uint public constant END = START + 5 days + 12 hours;
    uint public constant TOTAL_DISTRIBUTE_AMOUNT = 36000;
    uint constant MINIMAL_PROVIDE_AMOUNT = 100 ether;
    uint public totalProvided = 0;
    mapping(address => uint) public provided;
    IERC20 public immutable KTT;
    
    event Claimed(address indexed account, uint userShare, uint kttAmount);
    event Received(address indexed account, uint amount);
    
    constructor(IERC20 ktt) {
        KTT = ktt;
    }

    receive() external payable {
        require(START <= block.timestamp, "This initial offering has not started yet");
        require(block.timestamp <= END, "This offering has already ended");
        totalProvided += msg.value;
        provided[msg.sender] += msg.value;
        emit Received(msg.sender, msg.value);
    }
    
    function claim() external {
        address claimer = msg.sender;
        
        require(block.timestamp > END, "The initial offering runs now");
        require(provided[claimer] > 0, "you have no right to claim");
        
        uint userShare = provided[claimer];
        provided[claimer] = 0;
        
        if (totalProvided >= MINIMAL_PROVIDE_AMOUNT) {
            uint kttAmount = TOTAL_DISTRIBUTE_AMOUNT.mul(userShare).div(totalProvided);
            KTT.safeTransfer(claimer, kttAmount);
            emit Claimed(claimer, userShare, kttAmount);
        } else {
            payable(claimer).transfer(userShare);
            emit Claimed(claimer, userShare, 0);
        }
    }
    
    function withdrawProvidedETH() external onlyOwner {
        require(END < block.timestamp, "The offering must be completed");
        require(totalProvided >= MINIMAL_PROVIDE_AMOUNT, "The required amount has not been provided");
        
        payable(owner()).transfer(address(this).balance);
    } 
    
    function withdrawKTT() external onlyOwner {
        require(END < block.timestamp, "The offering must be completed");
        require(totalProvided >= MINIMAL_PROVIDE_AMOUNT, "The required amount has not been provided");
        
        KTT.safeTransfer(owner(), KTT.balanceOf(address(this)));
    }
    
    function withdrawUnclaimedKTT() external onlyOwner {
        require(END + 30 days < block.timestamp, "Withdrawal unavailable yet");
        KTT.safeTransfer(owner(), KTT.balanceOf(address(this)));
    }
}