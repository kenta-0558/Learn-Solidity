// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract CryptoPunksMarket {
    
    struct Offer {
        bool isForSale;
        uint punkIndex;
        address seller;
        uint minValue;
        address onlySellTo;
    }
    
    struct Bid {
        bool hasBid;
        uint punkIndex;
        address bidder;
        uint value;
    }
    
    mapping (uint => Offer) public punksOfferedForSale;
    mapping (uint => Bid) public punkBids;
    
    
    string public imageHash;
    address owner;
    string public standard = "CryptoPunks";
    string public name;
    // string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    uint public nextPunkIndexToAssign = 0;
    
    bool public allPunksAssigned = false;
    uint public punksRemainingToAssign = 0;
    
    mapping (uint => address) public punkIndexToAddress;
    
    mapping (address => uint256) public balanceOf;
    
    mapping (address => uint) public pendingWithdrawals;
    
    event Assign(address indexed to, uint256 punkIndex);
    event Transfer(address indexed from, address indexed to, uint256 value); // what does value mean in this case? number of punks?
    event PunkTransfer(address indexed from, address indexed to, uint256 punkIndex);
    event PunkOffered(uint indexed punkIndex, uint minValue, address indexed toAddress);
    event PunkBidEntered(uint indexed punkIndex, uint value, address indexed fromAddress);
    event PunkBidWithdrawn(uint indexed punkIndex, uint value, address indexed fromAddress);
    event PunkBought(uint indexed punkIndex, uint value, address indexed fromAddress, address indexed toAddress);
    event PunkNoLongerForSale(uint indexed punkIndex);
    
    modifier onlyOwner {
        require(owner == msg.sender, "You have no right to call this function");
        _;
    }
    
    modifier areAllPunksAssigned {
        require(!allPunksAssigned, "all punks have been already assigned");
        _;
    }
    
    modifier validPunk(uint _punkIndex) {
        require(_punkIndex <= 10000, "no more punk will be set");
        _;
    }
    
    modifier onlyPunkOwner(uint _punkIndex) {
      require(punkIndexToAddress[_punkIndex] == msg.sender, "You habe no right to transfer this punk.");      
      _;
    }
    
    // why payable ???
    // why not with constructor ???
    function initializeCryptoPunksMarket() public payable {
        
        owner = msg.sender;
        totalSupply = 10000;
        punksRemainingToAssign = totalSupply;
        name = "CRYPTOPUNKS";
        // symbol = "[]";
        decimals = 0;
    }
    
    function setInitialOwner(address _to, uint _punkIndex) public onlyOwner areAllPunksAssigned validPunk(_punkIndex) {
        
        if (punkIndexToAddress[_punkIndex] != _to) {
            if (punkIndexToAddress[_punkIndex] != address(0)) {
                balanceOf[punkIndexToAddress[_punkIndex]]--;
            } else {
                punksRemainingToAssign--;
            }
            punkIndexToAddress[_punkIndex] = _to;
            balanceOf[_to]++;
            emit Assign(_to, _punkIndex);
        }
    }
    
    function setInitialOwners(address[] calldata _addresses, uint[] calldata  _indices) external onlyOwner {
        for (uint i = 0; i < _addresses.length; i++) {
            setInitialOwner(_addresses[i], _indices[i]);
        }
    }
    
    function allInitialOnersAssigned() public onlyOwner {
        allPunksAssigned = true;
    }
    
    function getPunk(uint _punkIndex) external areAllPunksAssigned validPunk(_punkIndex) {
        
        require(punksRemainingToAssign != 0, "There is no more remaining punk");
        require(punkIndexToAddress[_punkIndex] == address(0), "You can not get punk with this index");
       
        punkIndexToAddress[_punkIndex] = msg.sender;
        balanceOf[msg.sender]++;
        punksRemainingToAssign--;
        emit Assign(msg.sender, _punkIndex);
    }
    
    function transferPunk(address _to, uint _punkIndex) public areAllPunksAssigned validPunk(_punkIndex) onlyPunkOwner(_punkIndex) {
        
        if (punksOfferedForSale[_punkIndex].isForSale) {
            punkNoLongerForSale(_punkIndex);
        } 
        punkIndexToAddress[_punkIndex] = _to;
        balanceOf[msg.sender]--;
        balanceOf[_to]++;
        
        emit Transfer(msg.sender, _to, 1); // value is 1 ???
        emit PunkTransfer(msg.sender, _to, _punkIndex);
        
        Bid memory bid = punkBids[_punkIndex];
        if (bid.bidder == _to) {
            pendingWithdrawals[_to] += bid.value;
            punkBids[_punkIndex] = Bid(false, _punkIndex, address(0), 0);
        }
    }

    function punkNoLongerForSale(uint _punkIndex) public areAllPunksAssigned validPunk(_punkIndex) onlyPunkOwner(_punkIndex) {
        punksOfferedForSale[_punkIndex] = Offer(false, _punkIndex, msg.sender, 0, address(0));
        emit PunkNoLongerForSale(_punkIndex);
    }

    function offerPunkForSale(
        uint _punkIndex, 
        uint minSalePriceInWei
    ) 
        public 
        areAllPunksAssigned 
        validPunk(_punkIndex) 
        onlyPunkOwner(_punkIndex) 
    {
        punksOfferedForSale[_punkIndex] = Offer(true, _punkIndex, msg.sender, minSalePriceInWei, address(0));
        emit PunkOffered(_punkIndex, minSalePriceInWei, address(0));
    }

    function offerPunkForSaleToAddress(
        uint _punkIndex, 
        uint minSalePriceInWei, 
        address _toAddress
    )
        public 
        areAllPunksAssigned
        validPunk(_punkIndex)
        onlyPunkOwner(_punkIndex)
    {
        punksOfferedForSale[_punkIndex] = Offer(true, _punkIndex, msg.sender, minSalePriceInWei, _toAddress);
        emit PunkOffered(_punkIndex, minSalePriceInWei, _toAddress);
    }

    function buyPunk(
        uint _punkIndex
    ) 
        public 
        payable 
        areAllPunksAssigned 
        validPunk(_punkIndex)    
    {
        Offer memory offer = punksOfferedForSale[_punkIndex];
        
        address seller = offer.seller;
        
        require(seller == punkIndexToAddress[_punkIndex], "Someone own this punk and he will not sell this");
        require(offer.isForSale, "This punk is not on sale");
        require(offer.onlySellTo == address(0) || offer.onlySellTo == msg.sender, "You can not buy this punk");
        require(msg.value >= offer.minValue, "You have to send more value");
        
        punkIndexToAddress[_punkIndex] = msg.sender;
        balanceOf[msg.sender]++;
        balanceOf[seller]--;
        
        emit Transfer(seller, msg.sender, 1); 
        
        punkNoLongerForSale(_punkIndex);
        pendingWithdrawals[seller] += msg.value;
        emit PunkBought(_punkIndex, msg.value, seller, msg.sender);
        
        Bid memory bid = punkBids[_punkIndex];
        if (bid.bidder == msg.sender) {
            pendingWithdrawals[msg.sender] += bid.value;
            punkBids[_punkIndex] =  Bid(false, _punkIndex, address(0), 0);
        }
    }

    function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function enterBidForPunk(
        uint _punkIndex
    ) 
        public 
        payable 
        validPunk(_punkIndex)
    {
        require(punkIndexToAddress[_punkIndex] != msg.sender, "You own already this punk");
        require(punkIndexToAddress[_punkIndex] != address(0), "Nobady has owned this punk until now");
        require(msg.value != 0, "You have to bid with sending value");
        
        
        Bid memory existingBid = punkBids[_punkIndex];
        
        require(msg.value > existingBid.value, "your bid value is not enough to beat existing bid");
        
        if (existingBid.value > 0) {
            pendingWithdrawals[existingBid.bidder] += existingBid.value;
        }
        
        punkBids[_punkIndex] = Bid(true, _punkIndex, msg.sender, msg.value);
        emit PunkBidEntered(_punkIndex, msg.value, msg.sender);
    }

    function withdrawBidForPunk(
        uint _punkIndex
    ) 
        public
        validPunk(_punkIndex)
    {
        Bid memory bid = punkBids[_punkIndex];
        
        require(bid.bidder == msg.sender, "You have no right to cancel this bid");
        
        uint amount = bid.value;
        payable(msg.sender).transfer(amount);
        punkBids[_punkIndex] = Bid(false, _punkIndex, address(0), 0);
        emit PunkBidWithdrawn(_punkIndex, bid.value, msg.sender);
    }

    function acceptBidForPunk(
        uint _punkIndex, 
        uint minPrice
    ) 
        public
        validPunk(_punkIndex)
    {
        require(punkIndexToAddress[_punkIndex] == msg.sender, "You are not owner of this punk");  
        
        address seller = msg.sender;
        Bid memory bid = punkBids[_punkIndex];
        
        require(bid.value != 0, "This bid has no price for punk");
        require(bid.value >= minPrice, "This bid does not have enough price");
        
        punkIndexToAddress[_punkIndex] = bid.bidder;
        balanceOf[bid.bidder]++;
        balanceOf[seller]--;
        emit Transfer(seller, bid.bidder, 1);
        
        uint amount = bid.value;
        pendingWithdrawals[seller] += amount;
        
        punksOfferedForSale[_punkIndex] = Offer(false, _punkIndex, bid.bidder, 0, address(0));
        punkBids[_punkIndex] = Bid(false, _punkIndex, address(0), 0);
        emit PunkBought(_punkIndex, amount, seller, bid.bidder);
    }

}