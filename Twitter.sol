// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;


contract Twitter {
    
    struct Tweet {
        uint id;
        address author;
        string content;
        uint createdAt;
    }
    
    struct Message {
        uint id;
        address from;
        address to;
        string content;
        uint createdAt;
    }

    mapping(uint => Tweet) public tweets;
    mapping(address => uint[]) public tweetsOf;
    mapping(address => address[]) public following;
    mapping(uint => Message[]) public conversations; 
    
    mapping(address => uint) public addressToIndex;

    uint private nextTweetId;
    uint private nextMassageId;
    uint private nextAddressIndex = 1;

    event TweetSent(
        uint id,
        address indexed author,
        string content,
        uint createdAt    
    );
    
    event MessageSent(
        uint id,
        address from,
        address to,
        uint createdAt
    );

    function tweet(string calldata _content) external {
        _tweet(msg.sender, _content);
    }
    
    function _tweet(
        address _from,
        string memory _content
    )
        internal 
        // canOperate(_from)
    {
        tweets[nextTweetId] = Tweet(nextTweetId, _from, _content, block.timestamp);
        tweetsOf[_from].push(nextTweetId);
        emit TweetSent(nextTweetId, _from, _content, block.timestamp);
        nextTweetId++;
    }
    
    function follow(address _followed) external {
        require(_followed != msg.sender, "You can not follow yourself");
        following[msg.sender].push(_followed);
    }
    
    function getFollowing() external view returns (address[] memory){
        return following[msg.sender];
    }
    
    function sendMessage(
        address _to,
        string calldata _content
    ) 
        external 
    {
        _sendMessage(msg.sender, _to, _content);
    }
    
    function _sendMessage(address _from, address _to, string memory _content) internal {
        
        if (addressToIndex[_from] == 0) {
            addressToIndex[_from] = nextAddressIndex;
            nextAddressIndex++;
        }
        
        if (addressToIndex[_to] == 0) {
            addressToIndex[_to] = nextAddressIndex;
            nextAddressIndex++;
        }
        
        uint conversationId = addressToIndex[_from] + addressToIndex[_to];
        conversations[conversationId].push(Message(
            nextMassageId,
            _from,
            _to,
            _content,
            block.timestamp            
        ));
    }
    
    function getConversation(address _address1, address _address2) external view returns (Message[] memory) {
        
        uint conversationId = addressToIndex[_address1] + addressToIndex[_address2];
        return conversations[conversationId];
    }
    
}