// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract StateMachine {
    
    enum Stages {
        AcceptingBlindeBids,
        RevealBids,
        AnotherStage,
        AreWeDoneYet,
        Finished
    }
    
    Stages public stage = Stages.AcceptingBlindeBids;
    
    uint public creationTime = block.timestamp;
    
    modifier atStage(Stages _stage) {
        require(stage == _stage, "this function can not be called now");
        _;
    }
    
    function nextStage() internal {
        stage = Stages(uint(stage) + 1);
    }
    
    modifier timedTransitions() {
        
        if (stage == Stages.AcceptingBlindeBids && block.timestamp >= creationTime + 2 minutes)
            nextStage();
            
        if (stage == Stages.RevealBids && block.timestamp >= creationTime + 5 minutes)
            nextStage();
            
        _;
        
    }
    
    function bid() public payable timedTransitions atStage(Stages.AcceptingBlindeBids) {
        
    }
    
    function reveal() public timedTransitions atStage(Stages.RevealBids) {
        
    } 
    
    modifier transitionNext() {
        _;
        nextStage();
    }
    
    function g() public timedTransitions atStage(Stages.AnotherStage) transitionNext {
        
    }
    
    function h() public timedTransitions atStage(Stages.AreWeDoneYet) transitionNext {
        
    }
    
    function i() public timedTransitions atStage(Stages.Finished) {
        
    }
    
}