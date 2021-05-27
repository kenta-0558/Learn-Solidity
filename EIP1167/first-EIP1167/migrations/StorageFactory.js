const Storage = artifacts.require("Storage");
const StorageFactory = artifacts.require("StorageFactory");

module.exports = async function (deployer) {
  const storage = await Storage.deployed();
  deployer.deploy(StorageFactory);
};