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
    mapping(address => uint[]) private tweetsOf;
    mapping(address => address[]) public following;
    mapping(uint => Message[]) public conversations;

    uint private nextTweetId;

    event TweetSent(
        uint id,
        address indexed author,
        string content,
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
    
}