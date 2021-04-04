// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

// Try enums from docs.soliditylang.org

contract test {
    enum ActionChoices { GoLeft, GoRight, GoStraight, SitStill }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;
    
    function setGoStraight() public {
        choice = ActionChoices.GoStraight;
    }
    
    function getChoice() public view returns (ActionChoices) {
        return choice;
    }
    
    function getDefaultChoice() public pure returns (uint) {
        return uint(defaultChoice);
    }
    
}

// try own code with enums

contract TryEnums {
    
    enum Size { XS, S, M, L, XL}
    Size orderedSize;
    Size constant defaultOrderedSize = Size.M;
    
    function getSize() public view returns (Size) {
        return orderedSize;
    }
    
    function getDefaultSize() public pure returns (Size) {
        return defaultOrderedSize;
    }
    
    function setSize(Size _size) public returns (Size) {
        require(uint8(_size) < 5);
        orderedSize = _size;
        return orderedSize;
    }

}

// examples from https://jeancvllr.medium.com/solidity-tutorial-all-about-enums-684adcc0b38e

contract CardDeck {
    
    enum Suit { Spades, Clubs, Diamonds, Hearts }
    enum Value { Two, Tree, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, King, Queen, Ace }
    
    struct Card {
        Suit suit;
        Value value;
    }
    
    Card public myCard;
    
    function pickCard(Suit _suit, Value _value) public returns (Suit, Value) {
        
        myCard.suit = _suit;
        myCard.value = _value;
        
        return (myCard.suit, myCard.value);
    }
}