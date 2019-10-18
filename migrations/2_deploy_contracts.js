const StoragePuzzles = artifacts.require("StoragePuzzles");
const LogicalPuzzlesCreation = artifacts.require("LogicalPuzzlesCreation");
const LogicalPuzzlesWithdraw = artifacts.require("LogicalPuzzlesWithdraw");
const LogicalPuzzlesArbitrable = artifacts.require("LogicalPuzzlesArbitrable");
const LogicalPuzzlesInitialization = artifacts.require("LogicalPuzzlesInitialization");
const LogicalPuzzlesDisputeWithdraw = artifacts.require("LogicalPuzzlesDisputeWithdraw");
const AutoAppealableArbitrator=artifacts.require("AutoAppealableArbitrator");



module.exports =  async function(deployer,network,accounts) {
  await deployer.deploy(AutoAppealableArbitrator,web3.utils.toWei("0.3","ether"),{from: accounts[9],gas: 1400000,gasPrice: 20000000000});
  await deployer.deploy(StoragePuzzles,AutoAppealableArbitrator.address,"0x",web3.utils.toWei("0.01","ether"),25,30,25,45,120,100,90,accounts[0], {from: accounts[0],gas:6800000,gasPrice: 20000000000}); 
  await  deployer.deploy(LogicalPuzzlesCreation,StoragePuzzles.address, {from: accounts[0],gas: 4800000,gasPrice: 20000000000});
  await deployer.deploy(LogicalPuzzlesWithdraw,StoragePuzzles.address, {from: accounts[0],gas: 6400000,gasPrice: 20000000000}); 
  await deployer.deploy(LogicalPuzzlesArbitrable,StoragePuzzles.address, {from: accounts[0],gas: 5100000,gasPrice: 20000000000});
  await deployer.deploy(LogicalPuzzlesInitialization,StoragePuzzles.address, {from: accounts[0],gas: 3200000,gasPrice: 20000000000});
  await deployer.deploy(LogicalPuzzlesDisputeWithdraw,StoragePuzzles.address, {from: accounts[0],gas: 4200000,gasPrice: 20000000000});
};
  
  
  
  
  
  
 
