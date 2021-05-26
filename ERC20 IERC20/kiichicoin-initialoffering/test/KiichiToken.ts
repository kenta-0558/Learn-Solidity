import { ethers } from 'hardhat';
import { expect } from 'chai';
import { BigNumber } from 'ethers';


describe("Kiichi Token deploy", () => {
    
    const initialSupply = 100;
    let kiichiToken: any;

    const provider = new ethers.providers.JsonRpcProvider();
    
    beforeEach(async () => {
        
        const kiichiTokenFactory = await ethers.getContractFactory("KiichiToken");
        kiichiToken = await kiichiTokenFactory.deploy(initialSupply);
        await kiichiToken.deployed();
    });
    
    it ("should have total supply", async () => {
        
        expect(await kiichiToken.totalSupply()).be.equal(initialSupply);
    });

    it("should transfer from one account to other", async () => {
        
        const [owner, addr1] = await ethers.getSigners();

        expect(await kiichiToken.balanceOf(owner.address)).to.equal(initialSupply);
        expect(await kiichiToken.balanceOf(addr1.address)).to.equal(0);
        
        const sendAmount = 50;

        await kiichiToken.transfer(addr1.address, sendAmount);

        const account1 = await kiichiToken.balanceOf(addr1.address)

        expect(await kiichiToken.balanceOf(owner.address)).to.equal(initialSupply - sendAmount);
        expect(account1).to.equal(sendAmount);
        expect(account1.toString()).to.equal(sendAmount.toString());
    });

    



})

