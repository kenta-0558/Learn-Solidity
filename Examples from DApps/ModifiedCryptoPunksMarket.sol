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
    event Transfer(address indexed from, address indexed to, uint256 value); // what does value mean in this case?
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
}