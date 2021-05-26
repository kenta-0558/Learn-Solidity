import { ethers } from 'hardhat';
import { smockit } from '@eth-optimism/smock';
import { Contract } from '@ethersproject/contracts';

describe("Kiichi initial offering", async () => {

    let kiichiToken: Contract;
    let initOffering: Contract;
    // any must be changed.
    let accounts: any;

    beforeEach(async () => {
        const kiichiTokenFactory = await ethers.getContractFactory("KiichiToken");
        kiichiToken = await kiichiTokenFactory.deploy(100);
        await kiichiToken.deployed();
       
        const initOfferingFactory = await ethers.getContractFactory("KiichiInitialOffering");
        initOffering = await initOfferingFactory.deploy(kiichiToken.address);
        await initOffering.deployed();
        
        accounts = await ethers.getSigners();
        
        console.log(accounts[0].address);
        console.log(await accounts[0].getAddress());
        console.log(await accounts[0].getBalance());
    });

    it("should ", async () => {
        
    });
});