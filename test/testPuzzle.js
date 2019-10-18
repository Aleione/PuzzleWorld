const StoragePuzzles = artifacts.require("StoragePuzzles");
const LogicalPuzzlesCreation = artifacts.require("LogicalPuzzlesCreation");
const LogicalPuzzlesWithdraw = artifacts.require("LogicalPuzzlesWithdraw");
const LogicalPuzzlesArbitrable = artifacts.require("LogicalPuzzlesArbitrable");
const LogicalPuzzlesInitialization = artifacts.require("LogicalPuzzlesInitialization");
const LogicalPuzzlesDisputeWithdraw = artifacts.require("LogicalPuzzlesDisputeWithdraw");
const AutoAppealableArbitrator=artifacts.require("AutoAppealableArbitrator");

contract('Puzzle',  async (accounts) => {
	before(async function () {
	   const InstanceAutoAppealableArbitrator= await AutoAppealableArbitrator.deployed();
       const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const owneraccount=accounts[0];
	   await InstanceStoragePuzzles.addLogicalContract(InstanceLogicalPuzzlesCreation.address,{from:owneraccount});
	   await InstanceStoragePuzzles.addLogicalContract(InstanceLogicalPuzzlesWithdraw.address,{from:owneraccount});
	   await InstanceStoragePuzzles.addLogicalContract(InstanceLogicalPuzzlesArbitrable.address,{from:owneraccount});
	   await InstanceStoragePuzzles.addLogicalContract(InstanceLogicalPuzzlesInitialization.address,{from:owneraccount});
	   await InstanceStoragePuzzles.addLogicalContract(InstanceLogicalPuzzlesDisputeWithdraw.address,{from:owneraccount});
	   await InstanceStoragePuzzles.AddGamesType(true,{from:owneraccount});
	   await InstanceStoragePuzzles.AddGamesType(false,{from:owneraccount});
	 });
	  
	it('propose game, not offers and game not submitted ', async () => {
       const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1];
	   const secret=web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt =await InstanceLogicalPuzzlesCreation.proposeGame("Rebus","http://gazzetta.it",0,[web3.utils.toWei("1","ether"),web3.utils.toWei("0.1","ether"),7],[10,30],200,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("3","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
       await timeout(15000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   const residual = await InstanceStoragePuzzles.getGameResidualJackpot.call(gameindex);
	   assert.equal(residual, 0, "Residual amount not null");
	   const upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)); //-firstAccountGas2;
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");
	   const contractaddress=InstanceStoragePuzzles.address;
	   assert.equal(await InstanceStoragePuzzles.getFeeBalance.call(),await web3.eth.getBalance(contractaddress), "storage contract amount not equal to fee");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
	   }
	 });
	 
	it ('propose game, offer and  game not submitted', async () => {
	   const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1];
	   const secret=await web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt=await InstanceLogicalPuzzlesCreation.proposeGame("Rebus2","http://gazzetta.it",0,[web3.utils.toWei("1","ether"),web3.utils.toWei("0.1","ether"),7],[15,30],200,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("3","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
       await timeout(5000);
	   const secondAccount=accounts[2];
	   const secondAccountBalance=await web3.eth.getBalance(secondAccount);
	   const secondAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:secondAccount,value:web3.utils.toWei("0.5","ether")});
	   const secondAccountGas=secondAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt.tx)).gasPrice);
	   const indexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,secondAccount,{from:secondAccount});
	   const expectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,indexoffer,{from:secondAccount});
	   assert.equal(expectedwin,web3.utils.toWei("0.5","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,indexoffer,{from:secondAccount}),expectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(10000);
	   await timeout(25000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   const residual = await InstanceStoragePuzzles.getGameResidualJackpot.call(gameindex);
	   assert.equal(residual, 0, "Residual amount not null");
	   const serviceFeeAnte=await InstanceStoragePuzzles.getFeeBalance.call()
	   const secondAccountReceipt2=await InstanceLogicalPuzzlesWithdraw.withdrawNonSubmittedGame(gameindex,{from:secondAccount});
	   const secondAccountGas2=secondAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt2.tx)).gasPrice);
	   const serviceFee=await InstanceStoragePuzzles.getFeeBalance.call()-serviceFeeAnte;
	   assert.equal(serviceFee,await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,indexoffer), "wrong fee");
	   const upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(expectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.5","ether"))); 
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");
	   const upgradeamountsecond=web3.utils.toBN(secondAccountBalance).sub(web3.utils.toBN(secondAccountGas)).sub(web3.utils.toBN(secondAccountGas2)).add(web3.utils.toBN(expectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).sub(web3.utils.toBN(serviceFee));
	   assert.equal(await web3.eth.getBalance(secondAccount),upgradeamountsecond, "second account amount wrong");
	   const contractaddress=InstanceStoragePuzzles.address;
	   assert.equal(await InstanceStoragePuzzles.getFeeBalance.call(),await web3.eth.getBalance(contractaddress), "storage contract amount not equal to fee");
	   const DaoAccount=accounts[0];
	   const addressStorage= InstanceStoragePuzzles.address;
	   await InstanceStoragePuzzles.withdrawFee(DaoAccount, await InstanceStoragePuzzles.getFeeBalance.call(), {from:DaoAccount});
	   assert.equal(await web3.eth.getBalance(addressStorage) ,0, "wrong balance fee");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesWithdraw=await InstanceLogicalPuzzlesWithdraw.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
	     console.log(eventsPuzzlesWithdraw);
	   }
	});
    
	it('propose game, offer, game submitted, solution creator', async () => {
	   const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1]; //account that create game
	   const secret=await web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt=await InstanceLogicalPuzzlesCreation.proposeGame("Rebus2","http://gazzetta.it",0,[web3.utils.toWei("1","ether"),web3.utils.toWei("0.1","ether"),7],[15,30],200,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("3","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
	   await timeout(2000);
	   const secondAccount=accounts[2]; //account that gives right solution
	   const secondAccountBalance=await web3.eth.getBalance(secondAccount);
	   const secondAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:secondAccount,value:web3.utils.toWei("0.5","ether")});
	   const secondAccountGas=secondAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt.tx)).gasPrice);
	   const secondindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,secondAccount,{from:secondAccount});
	   const secondexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,secondindexoffer,{from:secondAccount});
	   const secondFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,secondindexoffer,{from:secondAccount});
	   assert.equal(secondexpectedwin,web3.utils.toWei("0.5","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(secondFee,secondexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(2000);
	   const thirdAccount=accounts[3]; //account that gives wrong solution
	   const thirdAccountBalance=await web3.eth.getBalance(thirdAccount);
	   const thirdAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:thirdAccount,value:web3.utils.toWei("0.3","ether")});
	   const thirdAccountGas=thirdAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt.tx)).gasPrice);
	   const thirdindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,thirdAccount,{from:thirdAccount});
	   const thirdexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   const thirdFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   assert.equal(thirdexpectedwin,web3.utils.toWei("0.3","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(thirdFee,thirdexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fourthAccount=accounts[4]; //account that does not give hash solution
	   const fourthAccountBalance=await web3.eth.getBalance(fourthAccount);
	   const fourthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fourthAccount,value:web3.utils.toWei("0.8","ether")});
	   const fourthAccountGas=fourthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt.tx)).gasPrice);
	   const fourthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fourthAccount,{from:fourthAccount});
	   const fourthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   const fourthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   assert.equal(fourthexpectedwin,web3.utils.toWei("0.8","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fourthFee,fourthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fifthAccount=accounts[5]; //account that does not give hash solution
	   const fifthAccountBalance=await web3.eth.getBalance(fifthAccount);
	   const fifthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fifthAccount,value:web3.utils.toWei("0.4","ether")});
	   const fifthAccountGas=fifthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt.tx)).gasPrice);
	   const fifthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fifthAccount,{from:fifthAccount});
	   const fifthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   const fifthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   assert.equal(fifthexpectedwin,web3.utils.toWei("0.4","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fifthFee,fifthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(9000);
	   await timeout (5000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   const firstAccountReceipt3=await InstanceLogicalPuzzlesCreation.createGame(gameindex,"https://wikipedia.it",{from:firstAccount});
	   const firstAccountGas3=firstAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt3.tx)).gasPrice);
	   await timeout(10000)
	   const secondsecret=await web3.utils.keccak256("mypwdsecond");
	   const secondAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(secondsecret,solution),{from:secondAccount});
	   const secondAccountGas2=secondAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt2.tx)).gasPrice);
	   await timeout(5000);
	   const thirdsecret=await web3.utils.keccak256("mypwdthird");
	   const thirdsolution="This is third wrong solution"; //wrong solution
	   const thirdAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(thirdsecret,thirdsolution),{from:thirdAccount});
	   const thirdAccountGas2=thirdAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt2.tx)).gasPrice);
	   await timeout(5000);
	   const fourthsecret=await web3.utils.keccak256("mypwdfourth");
	   const fourthsolution="This is fourth wrong solution"; //wrong solution
	   const fourthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fourthsecret,fourthsolution),{from:fourthAccount});
	   const fourthAccountGas2=fourthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   await timeout(8000);
	   const secondAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,secondsecret,{from:secondAccount});
	   const secondAccountGas3=secondAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt3.tx)).gasPrice);
	   await timeout(10000);
	   const thirdAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,thirdsolution,thirdsecret,{from:thirdAccount});
	   const thirdAccountGas3=thirdAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt3.tx)).gasPrice);
	   await timeout(12000);
	   await timeout(15000);
	   const firstAccountReceipt4=await InstanceLogicalPuzzlesCreation.submitSolutionCreator(gameindex,solution,secret,{from:firstAccount});
	   const firstAccountGas4=firstAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt4.tx)).gasPrice);
	   await timeout(10000);
	   const serviceFeeAnte=await InstanceStoragePuzzles.getFeeBalance.call()
	   await timeout(10000);
	   var firstAccountReceipt5=await InstanceLogicalPuzzlesWithdraw.creatorWithdrawSingle(gameindex,fourthAccount,{from:firstAccount});
	   var firstAccountGas5=firstAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt5.tx)).gasPrice);
	   await timeout(40000);
	   const secondAccountReceipt4=await InstanceLogicalPuzzlesWithdraw.playerWithdraw(gameindex,{from:secondAccount});
	   const secondAccountGas4=secondAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const uniquewithdraw=false;
	   if (uniquewithdraw==true) {
	     var firstAccountReceipt6=await InstanceLogicalPuzzlesWithdraw.creatorWithdraw(gameindex,{from:firstAccount});
	     var firstAccountGas6=firstAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt6.tx)).gasPrice);
	   }
	   else {
	     var firstAccountReceipt6=await InstanceLogicalPuzzlesWithdraw.creatorWithdrawSingle(gameindex,thirdAccount,{from:firstAccount});
	     var firstAccountGas6=firstAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt6.tx)).gasPrice);
		 var firstAccountReceipt7=await InstanceLogicalPuzzlesWithdraw.creatorWithdrawSingle(gameindex,fifthAccount,{from:firstAccount});
		 var firstAccountGas7=firstAccountReceipt7.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt7.tx)).gasPrice);
	   }
	   const serviceFee=await InstanceStoragePuzzles.getFeeBalance.call()-serviceFeeAnte;
	   const upgradeServiceFee=web3.utils.toBN(secondFee).add(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(fourthFee)).add(web3.utils.toBN(fifthFee));
	   assert.equal(serviceFee,upgradeServiceFee, "wrong fee");
	   if (uniquewithdraw==true) {
	     var upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(firstAccountGas3)).sub(web3.utils.toBN(firstAccountGas4)).sub(web3.utils.toBN(firstAccountGas5)).sub(web3.utils.toBN(firstAccountGas6)).sub(web3.utils.toBN(secondexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).add(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(web3.utils.toWei("0.8","ether"))).sub(web3.utils.toBN(fourthFee)).add(web3.utils.toBN(web3.utils.toWei("0.4","ether"))).sub(web3.utils.toBN(fifthFee)); 
	   }
	   else {
	     var upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(firstAccountGas3)).sub(web3.utils.toBN(firstAccountGas4)).sub(web3.utils.toBN(firstAccountGas5)).sub(web3.utils.toBN(firstAccountGas6)).sub(web3.utils.toBN(firstAccountGas7)).sub(web3.utils.toBN(secondexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).add(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(thirdFee).add(web3.utils.toBN(web3.utils.toWei("0.8","ether"))).sub(fourthFee).add(web3.utils.toBN(web3.utils.toWei("0.4","ether"))).sub(web3.utils.toBN(fifthFee)); 
	   }
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");		
	   const upgradeamountsecond=web3.utils.toBN(secondAccountBalance).sub(web3.utils.toBN(secondAccountGas)).sub(web3.utils.toBN(secondAccountGas2)).sub(web3.utils.toBN(secondAccountGas3)).sub(web3.utils.toBN(secondAccountGas4)).add(web3.utils.toBN(secondexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).sub(web3.utils.toBN(secondFee));
	   assert.equal(await web3.eth.getBalance(secondAccount),upgradeamountsecond, "Second account amount wrong");
	   const upgradeamountthird=web3.utils.toBN(thirdAccountBalance).sub(web3.utils.toBN(thirdAccountGas)).sub(web3.utils.toBN(thirdAccountGas2)).sub(web3.utils.toBN(thirdAccountGas3)).sub(web3.utils.toBN(web3.utils.toWei("0.3","ether")));
	   assert.equal(await web3.eth.getBalance(thirdAccount),upgradeamountthird, "Third account amount wrong");
	   const upgradeamountfourth=web3.utils.toBN(fourthAccountBalance).sub(web3.utils.toBN(fourthAccountGas)).sub(web3.utils.toBN(fourthAccountGas2)).sub(web3.utils.toBN(web3.utils.toWei("0.8","ether")));
	   assert.equal(await web3.eth.getBalance(fourthAccount),upgradeamountfourth, "Fourth account amount wrong");
	   const upgradeamountfifth=web3.utils.toBN(fifthAccountBalance).sub(web3.utils.toBN(fifthAccountGas)).sub(web3.utils.toBN(web3.utils.toWei("0.4","ether")));
	   assert.equal(await web3.eth.getBalance(fifthAccount),upgradeamountfifth, "Fifth account amount wrong");
	   const DaoAccount=accounts[0];
	   const addressStorage= InstanceStoragePuzzles.address;
	   await InstanceStoragePuzzles.withdrawFee(DaoAccount, await InstanceStoragePuzzles.getFeeBalance.call(), {from:DaoAccount});
	   assert.equal(await web3.eth.getBalance(addressStorage) ,0, "wrong balance fee");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesWithdraw=await InstanceLogicalPuzzlesWithdraw.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
	     console.log(eventsPuzzlesWithdraw);
	   }
	});
	
	it('propose game, offer, game submitted, no solution creator', async () => {
	   const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1]; //account that create game
	   const secret=await web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt=await InstanceLogicalPuzzlesCreation.proposeGame("Rebus2","http://gazzetta.it",0,[web3.utils.toWei("1","ether"),web3.utils.toWei("0.1","ether"),7],[15,30],150,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("3","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
	   await timeout(2000);
	   const secondAccount=accounts[2]; //account that gives right solution
	   const secondAccountBalance=await web3.eth.getBalance(secondAccount);
	   const secondAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:secondAccount,value:web3.utils.toWei("0.5","ether")});
	   const secondAccountGas=secondAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt.tx)).gasPrice);
	   const secondindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,secondAccount,{from:secondAccount});
	   const secondexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,secondindexoffer,{from:secondAccount});
	   const secondFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,secondindexoffer,{from:secondAccount});
	   assert.equal(secondexpectedwin,web3.utils.toWei("0.5","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex)) /100,"wrong expected win");
	   assert.equal(secondFee,secondexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(2000);
	   const thirdAccount=accounts[3]; //account that gives wrong solution
	   const thirdAccountBalance=await web3.eth.getBalance(thirdAccount);
	   const thirdAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:thirdAccount,value:web3.utils.toWei("0.3","ether")});
	   const thirdAccountGas=thirdAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt.tx)).gasPrice);
	   const thirdindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,thirdAccount,{from:thirdAccount});
	   const thirdexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   const thirdFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   assert.equal(thirdexpectedwin,web3.utils.toWei("0.3","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(thirdFee,thirdexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fourthAccount=accounts[4]; //account that does not give hash solution
	   const fourthAccountBalance=await web3.eth.getBalance(fourthAccount);
	   const fourthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fourthAccount,value:web3.utils.toWei("0.8","ether")});
	   const fourthAccountGas=fourthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt.tx)).gasPrice);
	   const fourthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fourthAccount,{from:fourthAccount});
	   const fourthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   const fourthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   assert.equal(fourthexpectedwin,web3.utils.toWei("0.8","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fourthFee,fourthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fifthAccount=accounts[5]; //account that does not give hash solution
	   const fifthAccountBalance=await web3.eth.getBalance(fifthAccount);
	   const fifthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fifthAccount,value:web3.utils.toWei("0.4","ether")});
	   const fifthAccountGas=fifthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt.tx)).gasPrice);
	   const fifthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fifthAccount,{from:fifthAccount});
	   const fifthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   const fifthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   assert.equal(fifthexpectedwin,web3.utils.toWei("0.4","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fifthFee,fifthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(9000);
	   await timeout (5000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   const firstAccountReceipt3=await InstanceLogicalPuzzlesCreation.createGame(gameindex,"https://wikipedia.it",{from:firstAccount});
	   const firstAccountGas3=firstAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt3.tx)).gasPrice);
	   await timeout(10000)
	   const secondsecret=await web3.utils.keccak256("mypwdsecond");
	   const secondAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(secondsecret,solution),{from:secondAccount});
	   const secondAccountGas2=secondAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt2.tx)).gasPrice);
	   await timeout(5000);
	   const thirdsecret=await web3.utils.keccak256("mypwdthird");
	   const thirdsolution="This is third wrong solution"; //wrong solution
	   const thirdAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(thirdsecret,thirdsolution),{from:thirdAccount});
	   const thirdAccountGas2=thirdAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt2.tx)).gasPrice);
	   await timeout(5000);
	   const fourthsecret=await web3.utils.keccak256("mypwdfourth");
	   const fourthsolution="This is fourth wrong solution"; //wrong solution
	   const fourthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fourthsecret,fourthsolution),{from:fourthAccount});
	   const fourthAccountGas2=fourthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   await timeout(8000);
	   const secondAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,secondsecret,{from:secondAccount});
	   const secondAccountGas3=secondAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt3.tx)).gasPrice);
	   await timeout(10000);
	   const thirdAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,thirdsolution,thirdsecret,{from:thirdAccount});
	   const thirdAccountGas3=thirdAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt3.tx)).gasPrice);
	   await timeout(12000);
	   await timeout(25000);
	   const serviceFeeAnte=await InstanceStoragePuzzles.getFeeBalance.call();
	   await timeout(5000);
	   const secondAccountReceipt4=await InstanceLogicalPuzzlesWithdraw.playerWithdraw(gameindex,{from:secondAccount});
	   const secondAccountGas4=secondAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const thirdAccountReceipt4=await InstanceLogicalPuzzlesWithdraw.playerWithdraw(gameindex,{from:thirdAccount});
	   const thirdAccountGas4=thirdAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const uniquewithdraw=false;
	   if (uniquewithdraw==true) {
	     var firstAccountReceipt4=await InstanceLogicalPuzzlesWithdraw.bothNoSolutionCreatorWithdraw(gameindex,{from:firstAccount});
	     var firstAccountGas4=firstAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt4.tx)).gasPrice);
	   }
	   else {
	     var firstAccountReceipt4=await InstanceLogicalPuzzlesWithdraw.bothNoSolutionCreatorWithdrawSingle(gameindex,fourthAccount,{from:firstAccount});
	     var firstAccountGas4=firstAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt4.tx)).gasPrice);
		 var fifthAccountReceipt2=await InstanceLogicalPuzzlesWithdraw.bothNoSolutionPlayerWithdraw(gameindex,{from:fifthAccount});
	     var fifthAccountGas2=fifthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt2.tx)).gasPrice);
	   }
	   const serviceFee=await InstanceStoragePuzzles.getFeeBalance.call()-serviceFeeAnte;
	   const upgradeServiceFee=web3.utils.toBN(secondFee).add(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(fourthFee)).add(web3.utils.toBN(fifthFee));
	   assert.equal(serviceFee,upgradeServiceFee, "wrong fee");
	   const upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(firstAccountGas3)).sub(web3.utils.toBN(firstAccountGas4)).sub(web3.utils.toBN(secondexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).sub(web3.utils.toBN(thirdexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(web3.utils.toBN(fourthFee/2)).sub(web3.utils.toBN(fifthFee/2));
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");		
	   const upgradeamountsecond=web3.utils.toBN(secondAccountBalance).sub(web3.utils.toBN(secondAccountGas)).sub(web3.utils.toBN(secondAccountGas2)).sub(web3.utils.toBN(secondAccountGas3)).sub(web3.utils.toBN(secondAccountGas4)).add(web3.utils.toBN(secondexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).sub(web3.utils.toBN(secondFee));
	   assert.equal(await web3.eth.getBalance(secondAccount),upgradeamountsecond, "Second account amount wrong");
	   const upgradeamountthird=web3.utils.toBN(thirdAccountBalance).sub(web3.utils.toBN(thirdAccountGas)).sub(web3.utils.toBN(thirdAccountGas2)).sub(web3.utils.toBN(thirdAccountGas3)).sub(web3.utils.toBN(thirdAccountGas4)).add(web3.utils.toBN(thirdexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(web3.utils.toBN(thirdFee));
	   assert.equal(await web3.eth.getBalance(thirdAccount),upgradeamountthird, "Third account amount wrong");
	   const upgradeamountfourth=web3.utils.toBN(fourthAccountBalance).sub(web3.utils.toBN(fourthAccountGas)).sub(web3.utils.toBN(fourthAccountGas2)).sub(web3.utils.toBN(fourthFee/2));
	   assert.equal(await web3.eth.getBalance(fourthAccount),upgradeamountfourth, "Fourth account amount wrong");
	   if (uniquewithdraw==true) {
		  var upgradeamountfifth=web3.utils.toBN(fifthAccountBalance).sub(web3.utils.toBN(fifthAccountGas)).sub(web3.utils.toBN(fifthFee/2));
	   }
	   else {
		  var upgradeamountfifth=web3.utils.toBN(fifthAccountBalance).sub(web3.utils.toBN(fifthAccountGas)).sub(web3.utils.toBN(fifthAccountGas2)).sub(web3.utils.toBN(fifthFee/2));
	   }
	   assert.equal(await web3.eth.getBalance(fifthAccount),upgradeamountfifth, "Fifth account amount wrong");
	   const DaoAccount=accounts[0];
	   const addressStorage= InstanceStoragePuzzles.address;
	   await InstanceStoragePuzzles.withdrawFee(DaoAccount, await InstanceStoragePuzzles.getFeeBalance.call(), {from:DaoAccount});
	   assert.equal(await web3.eth.getBalance(addressStorage) ,0, "wrong balance fee");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesWithdraw=await InstanceLogicalPuzzlesWithdraw.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
	     console.log(eventsPuzzlesWithdraw);
	   }
	});
	
	//Dispute test
	
	it("game sumbitted and offers, parties does not accept dispute", async () => {
	   const InstanceAutoAppealableArbitrator= await AutoAppealableArbitrator.deployed();
	   const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1]; //account that create game
	   const secret=await web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt=await InstanceLogicalPuzzlesCreation.proposeGame("Rebus2","http://gazzetta.it",0,[web3.utils.toWei("1","ether"),web3.utils.toWei("0.1","ether"),7],[15,30],150,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("3","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
	   await timeout(2000);
	   const secondAccount=accounts[2]; //account that gives right solution but not cover dispute fee
	   const secondAccountBalance=await web3.eth.getBalance(secondAccount);
	   const secondAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:secondAccount,value:web3.utils.toWei("0.5","ether")});
	   const secondAccountGas=secondAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt.tx)).gasPrice);
	   const secondindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,secondAccount,{from:secondAccount});
	   const secondexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,secondindexoffer,{from:secondAccount});
	   const secondFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,secondindexoffer,{from:secondAccount});
	   assert.equal(secondexpectedwin,web3.utils.toWei("0.5","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex)) /100,"wrong expected win");
	   assert.equal(secondFee,secondexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(2000);
	   const thirdAccount=accounts[3]; //account that gives wrong solution and initiate dispute
	   const thirdAccountBalance=await web3.eth.getBalance(thirdAccount);
	   const thirdAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:thirdAccount,value:web3.utils.toWei("0.3","ether")});
	   const thirdAccountGas=thirdAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt.tx)).gasPrice);
	   const thirdindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,thirdAccount,{from:thirdAccount});
	   const thirdexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   const thirdFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   assert.equal(thirdexpectedwin,web3.utils.toWei("0.3","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(thirdFee,thirdexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fourthAccount=accounts[4]; //account that gives rights solution cover dispute fee but creator does not due to fee increase
	   const fourthAccountBalance=await web3.eth.getBalance(fourthAccount);
	   const fourthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fourthAccount,value:web3.utils.toWei("0.8","ether")});
	   const fourthAccountGas=fourthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt.tx)).gasPrice);
	   const fourthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fourthAccount,{from:fourthAccount});
	   const fourthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   const fourthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   assert.equal(fourthexpectedwin,web3.utils.toWei("0.8","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fourthFee,fourthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fifthAccount=accounts[5]; //account that gives wrong solution initiate dispute, creator cover but it doesn't cover doe to fee increase
	   const fifthAccountBalance=await web3.eth.getBalance(fifthAccount);
	   const fifthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fifthAccount,value:web3.utils.toWei("0.4","ether")});
	   const fifthAccountGas=fifthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt.tx)).gasPrice);
	   const fifthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fifthAccount,{from:fifthAccount});
	   const fifthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   const fifthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   assert.equal(fifthexpectedwin,web3.utils.toWei("0.4","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fifthFee,fifthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(9000);
	   await timeout (5000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   const firstAccountReceipt3=await InstanceLogicalPuzzlesCreation.createGame(gameindex,"https://wikipedia.it",{from:firstAccount});
	   const firstAccountGas3=firstAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt3.tx)).gasPrice);
	   await timeout(10000)
	   const secondsecret=await web3.utils.keccak256("mypwdsecond");
	   const secondAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(secondsecret,solution),{from:secondAccount});
	   const secondAccountGas2=secondAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt2.tx)).gasPrice);
	   await timeout(3000);
	   const thirdsecret=await web3.utils.keccak256("mypwdthird");
	   const thirdsolution="This is third wrong solution"; //wrong solution
	   const thirdAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(thirdsecret,thirdsolution),{from:thirdAccount});
	   const thirdAccountGas2=thirdAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt2.tx)).gasPrice);
	   await timeout(5000);
	   const fourthsecret=await web3.utils.keccak256("mypwdfourth");
	   const fourthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fourthsecret,solution),{from:fourthAccount});
	   const fourthAccountGas2=fourthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const fifthsecret=await web3.utils.keccak256("mypwdfifth");
	   const fifthsolution="This is fifth wrong solution"; //wrong solution
	   const fifthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fifthsecret,fifthsolution),{from:fifthAccount});
	   const fifthAccountGas2=fifthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   await timeout(6000);
	   const secondAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,secondsecret,{from:secondAccount});
	   const secondAccountGas3=secondAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt3.tx)).gasPrice);
	   await timeout(8000);
	   const thirdAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,thirdsolution,thirdsecret,{from:thirdAccount});
	   const thirdAccountGas3=thirdAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const fourthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,fourthsecret,{from:fourthAccount});
	   const fourthAccountGas3=fourthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const fifthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,fifthsolution,fifthsecret,{from:fifthAccount});
	   const fifthAccountGas3=fifthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt3.tx)).gasPrice);
	   await timeout(8000);
	   await timeout(15000);
	   const firstAccountReceipt4=await InstanceLogicalPuzzlesCreation.submitSolutionCreator(gameindex,solution,secret,{from:firstAccount});
	   const firstAccountGas4=firstAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt4.tx)).gasPrice);
	   await timeout(10000);  
	   await timeout(3000);
	   var arbitratorExtraData=await InstanceStoragePuzzles.getarbitratorExtraData.call();
	   if (arbitratorExtraData==null) {
		   arbitratorExtraData="0x";
	   }
	   var arbitratorFee= await InstanceAutoAppealableArbitrator.arbitrationCost.call(arbitratorExtraData);
	   const firstAccountReceipt5=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, secondAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas5=firstAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt5.tx)).gasPrice);
	   await timeout(12000);
	   const thirdAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:thirdAccount, value:arbitratorFee});
	   const thirdAccountGas4=thirdAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt6=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, fourthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas6=firstAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt6.tx)).gasPrice);
	   await timeout(15000);
	   const fifthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fifthAccount, value:arbitratorFee});
	   const fifthAccountGas4=fifthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt4.tx)).gasPrice);
	   await timeout(10000);
	   const arbitratorAccount=accounts[9];
	   await InstanceAutoAppealableArbitrator.setArbitrationPrice(web3.utils.toWei("0.45","ether"), {from:arbitratorAccount})
	   const arbitratorFee2= await InstanceAutoAppealableArbitrator.arbitrationCost.call(arbitratorExtraData);
	   await timeout(30000);
	   const fourthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fourthAccount, value:arbitratorFee2});
	   const fourthAccountGas4=fourthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt4.tx)).gasPrice);
	   await timeout(15000);
	   const firstAccountReceipt7=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, fifthAccount,{from:firstAccount, value:arbitratorFee2});
	   const firstAccountGas7=firstAccountReceipt7.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt7.tx)).gasPrice);
	   const serviceFeeAnte=await InstanceStoragePuzzles.getFeeBalance.call();
	   await timeout(20000);
	   const firstAccountReceipt8= await InstanceLogicalPuzzlesDisputeWithdraw.timeOutByCreator(gameindex,secondAccount,{from:firstAccount});
	   const firstAccountGas8=firstAccountReceipt8.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt8.tx)).gasPrice);
	   await timeout(12000);
	   const thirdAccountReceipt5=await InstanceLogicalPuzzlesDisputeWithdraw.timeOutByPlayer(gameindex,{from:thirdAccount});
	   const thirdAccountGas5=thirdAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt5.tx)).gasPrice);
	   await timeout(60000);
	   const fourthAccountReceipt5=await InstanceLogicalPuzzlesDisputeWithdraw.timeOutByPlayer(gameindex,{from:fourthAccount});
	   const fourthAccountGas5=fourthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt5.tx)).gasPrice);
	   await timeout(15000);
	   const firstAccountReceipt9= await InstanceLogicalPuzzlesDisputeWithdraw.timeOutByCreator(gameindex,fifthAccount,{from:firstAccount});
	   const firstAccountGas9=firstAccountReceipt9.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt9.tx)).gasPrice);
	   const serviceFee=await InstanceStoragePuzzles.getFeeBalance.call()-serviceFeeAnte;
	   const upgradeServiceFee=web3.utils.toBN(secondFee).add(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(fourthFee)).add(web3.utils.toBN(fifthFee));
	   assert.equal(serviceFee,upgradeServiceFee, "wrong fee");
	   const upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(firstAccountGas3)).sub(web3.utils.toBN(firstAccountGas4)).sub(web3.utils.toBN(firstAccountGas5)).sub(web3.utils.toBN(firstAccountGas6)).sub(web3.utils.toBN(firstAccountGas7)).sub(web3.utils.toBN(firstAccountGas8)).sub(web3.utils.toBN(firstAccountGas9)).add(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).sub(web3.utils.toBN(secondFee)).sub(web3.utils.toBN(thirdexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(web3.utils.toBN(fourthexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.8","ether"))).add(web3.utils.toBN(web3.utils.toWei("0.4","ether"))).sub(web3.utils.toBN(fifthFee));
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");
	   const upgradeamountsecond=web3.utils.toBN(secondAccountBalance).sub(web3.utils.toBN(secondAccountGas)).sub(web3.utils.toBN(secondAccountGas2)).sub(web3.utils.toBN(secondAccountGas3)).sub(web3.utils.toBN(web3.utils.toWei("0.5","ether")));
	   assert.equal(await web3.eth.getBalance(secondAccount),upgradeamountsecond, "Second account amount wrong");
	   const upgradeamountthird=web3.utils.toBN(thirdAccountBalance).sub(web3.utils.toBN(thirdAccountGas)).sub(web3.utils.toBN(thirdAccountGas2)).sub(web3.utils.toBN(thirdAccountGas3)).sub(web3.utils.toBN(thirdAccountGas4)).sub(web3.utils.toBN(thirdAccountGas5)).add(web3.utils.toBN(thirdexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(web3.utils.toBN(thirdFee));
	   assert.equal(await web3.eth.getBalance(thirdAccount),upgradeamountthird, "Third account amount wrong");
	   const upgradeamountfourth=web3.utils.toBN(fourthAccountBalance).sub(web3.utils.toBN(fourthAccountGas)).sub(web3.utils.toBN(fourthAccountGas2)).sub(web3.utils.toBN(fourthAccountGas3)).sub(web3.utils.toBN(fourthAccountGas4)).sub(web3.utils.toBN(fourthAccountGas5)).add(web3.utils.toBN(fourthexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.8","ether"))).sub(web3.utils.toBN(fourthFee));
	   assert.equal(await web3.eth.getBalance(fourthAccount),upgradeamountfourth, "Fourth account amount wrong");
	   const upgradeamountfifth=web3.utils.toBN(fifthAccountBalance).sub(web3.utils.toBN(fifthAccountGas)).sub(web3.utils.toBN(fifthAccountGas2)).sub(web3.utils.toBN(fifthAccountGas3)).sub(web3.utils.toBN(fifthAccountGas4)).sub(web3.utils.toBN(web3.utils.toWei("0.4","ether")));
	   assert.equal(await web3.eth.getBalance(fifthAccount),upgradeamountfifth, "Fifth account amount wrong");
       const DaoAccount=accounts[0];
	   const addressStorage= InstanceStoragePuzzles.address;
	   await InstanceStoragePuzzles.withdrawFee(DaoAccount, await InstanceStoragePuzzles.getFeeBalance.call(), {from:DaoAccount});
	   assert.equal(await web3.eth.getBalance(addressStorage) ,0, "wrong balance fee");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
		 const eventsPuzzlesInitialization=await InstanceLogicalPuzzlesInitialization.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesWithdraw=await InstanceLogicalPuzzlesWithdraw.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
		 console.log(eventsPuzzlesInitialization);
	     console.log(eventsPuzzlesWithdraw);
	   }
	});
	
	it("game sumbitted and offers, parties accept dispute no appeal", async () => {
	   const InstanceAutoAppealableArbitrator= await AutoAppealableArbitrator.deployed();
	   const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1]; //account that create game
	   const secret=await web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt=await InstanceLogicalPuzzlesCreation.proposeGame("Rebus2","http://gazzetta.it",0,[web3.utils.toWei("1","ether"),web3.utils.toWei("0.1","ether"),7],[15,30],150,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("3","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
	   await timeout(1000);
	   const secondAccount=accounts[2]; //account with right solution that will win dispute
	   const secondAccountBalance=await web3.eth.getBalance(secondAccount);
	   const secondAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:secondAccount,value:web3.utils.toWei("0.5","ether")});
	   const secondAccountGas=secondAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt.tx)).gasPrice);
	   const secondindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,secondAccount,{from:secondAccount});
	   const secondexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,secondindexoffer,{from:secondAccount});
	   const secondFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,secondindexoffer,{from:secondAccount});
	   assert.equal(secondexpectedwin,web3.utils.toWei("0.5","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex)) /100,"wrong expected win");
	   assert.equal(secondFee,secondexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const thirdAccount=accounts[3]; //account with wrong solution that will lose dispute
	   const thirdAccountBalance=await web3.eth.getBalance(thirdAccount);
	   const thirdAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:thirdAccount,value:web3.utils.toWei("0.3","ether")});
	   const thirdAccountGas=thirdAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt.tx)).gasPrice);
	   const thirdindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,thirdAccount,{from:thirdAccount});
	   const thirdexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   const thirdFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   assert.equal(thirdexpectedwin,web3.utils.toWei("0.3","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(thirdFee,thirdexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fourthAccount=accounts[4]; //account with right solution that will lose dispute
	   const fourthAccountBalance=await web3.eth.getBalance(fourthAccount);
	   const fourthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fourthAccount,value:web3.utils.toWei("0.8","ether")});
	   const fourthAccountGas=fourthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt.tx)).gasPrice);
	   const fourthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fourthAccount,{from:fourthAccount});
	   const fourthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   const fourthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   assert.equal(fourthexpectedwin,web3.utils.toWei("0.8","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fourthFee,fourthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fifthAccount=accounts[5]; //account with wrong solution that will win dispute
	   const fifthAccountBalance=await web3.eth.getBalance(fifthAccount);
	   const fifthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fifthAccount,value:web3.utils.toWei("0.4","ether")});
	   const fifthAccountGas=fifthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt.tx)).gasPrice);
	   const fifthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fifthAccount,{from:fifthAccount});
	   const fifthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   const fifthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   assert.equal(fifthexpectedwin,web3.utils.toWei("0.4","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fifthFee,fifthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const sixthAccount=accounts[6]; //account with right solution and not winner dispute
	   const sixthAccountBalance=await web3.eth.getBalance(sixthAccount);
	   const sixthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:sixthAccount,value:web3.utils.toWei("0.7","ether")});
	   const sixthAccountGas=sixthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt.tx)).gasPrice);
	   const sixthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,sixthAccount,{from:sixthAccount});
	   const sixthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,sixthindexoffer,{from:sixthAccount});
	   const sixthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,sixthindexoffer,{from:sixthAccount});
	   assert.equal(sixthexpectedwin,web3.utils.toWei("0.7","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(sixthFee,sixthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const seventhAccount=accounts[7]; //account with wrong solution and not winner dispute
	   const seventhAccountBalance=await web3.eth.getBalance(seventhAccount);
	   const seventhAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:seventhAccount,value:web3.utils.toWei("0.6","ether")});
	   const seventhAccountGas=seventhAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt.tx)).gasPrice);
	   const seventhindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,seventhAccount,{from:seventhAccount});
	   const seventhexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,seventhindexoffer,{from:seventhAccount});
	   const seventhFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,seventhindexoffer,{from:seventhAccount});
	   assert.equal(seventhexpectedwin,web3.utils.toWei("0.6","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(seventhFee,seventhexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(9000);
	   await timeout (5000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   const firstAccountReceipt3=await InstanceLogicalPuzzlesCreation.createGame(gameindex,"https://wikipedia.it",{from:firstAccount});
	   const firstAccountGas3=firstAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt3.tx)).gasPrice);
	   await timeout(10000);
	   const secondsecret=await web3.utils.keccak256("mypwdsecond");
	   const secondAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(secondsecret,solution),{from:secondAccount});
	   const secondAccountGas2=secondAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const thirdsecret=await web3.utils.keccak256("mypwdthird");
	   const thirdsolution="This is third wrong solution"; //wrong solution
	   const thirdAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(thirdsecret,thirdsolution),{from:thirdAccount});
	   const thirdAccountGas2=thirdAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt2.tx)).gasPrice);
	   await timeout(3000);
	   const fourthsecret=await web3.utils.keccak256("mypwdfourth");
	   const fourthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fourthsecret,solution),{from:fourthAccount});
	   const fourthAccountGas2=fourthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const fifthsecret=await web3.utils.keccak256("mypwdfifth");
	   const fifthsolution="This is fifth wrong solution"; //wrong solution
	   const fifthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fifthsecret,fifthsolution),{from:fifthAccount});
	   const fifthAccountGas2=fifthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt2.tx)).gasPrice);
	   await timeout(3000);
	   const sixthsecret=await web3.utils.keccak256("mypwdsixth");
	   const sixthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(sixthsecret,solution),{from:sixthAccount});
	   const sixthAccountGas2=sixthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const seventhsecret=await web3.utils.keccak256("mypwdseventh");
	   const seventhsolution="This is seventh wrong solution"; //wrong solution
	   const seventhAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(seventhsecret,seventhsolution),{from:seventhAccount});
	   const seventhAccountGas2=seventhAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt2.tx)).gasPrice);
	   await timeout(8000);
	   await timeout(4000);
	   const secondAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,secondsecret,{from:secondAccount});
	   const secondAccountGas3=secondAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt3.tx)).gasPrice);
	   const secondAccountReceipt4=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://tron.network",{from:secondAccount});
	   const secondAccountGas4=secondAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt4.tx)).gasPrice);
	   await timeout(3000);
	   const thirdAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,thirdsolution,thirdsecret,{from:thirdAccount});
	   const thirdAccountGas3=thirdAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const fourthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,fourthsecret,{from:fourthAccount});
	   const fourthAccountGas3=fourthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const fifthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,fifthsolution,fifthsecret,{from:fifthAccount});
	   const fifthAccountGas3=fifthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt3.tx)).gasPrice);
	   await timeout(3000);
	   const sixthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,sixthsecret,{from:sixthAccount});
	   const sixthAccountGas3=sixthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const seventhAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,seventhsolution,seventhsecret,{from:seventhAccount});
	   const seventhAccountGas3=seventhAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt3.tx)).gasPrice);
	   await timeout(8000);
	   await timeout(15000);
	   const firstAccountReceipt4=await InstanceLogicalPuzzlesCreation.submitSolutionCreator(gameindex,solution,secret,{from:firstAccount});
	   const firstAccountGas4=firstAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt4.tx)).gasPrice);
	   const firstAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,secondAccount,"https://ripple.com",{from:firstAccount});
	   const firstAccountGas5=firstAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt5.tx)).gasPrice);
	   await timeout(10000);  
	   await timeout(3000);
	   var arbitratorExtraData=await InstanceStoragePuzzles.getarbitratorExtraData.call();
	   if (arbitratorExtraData==null) {
		   arbitratorExtraData="0x";
	   }
	   var arbitratorFee= await InstanceAutoAppealableArbitrator.arbitrationCost.call(arbitratorExtraData);
	   var arbitratorFeeIncreased=(web3.utils.toBN(arbitratorFee)).add(web3.utils.toBN(web3.utils.toWei("0.1","ether")));
	   const firstAccountReceipt6=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, secondAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas6=firstAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt6.tx)).gasPrice);
	   await timeout(5000);
	   const thirdAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:thirdAccount, value:arbitratorFee});
	   const thirdAccountGas4=thirdAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt7=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, fourthAccount,{from:firstAccount, value:arbitratorFeeIncreased});
	   const firstAccountGas7=firstAccountReceipt7.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt7.tx)).gasPrice);
	   await timeout(5000);
	   const fifthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fifthAccount, value:arbitratorFeeIncreased});
	   const fifthAccountGas4=fifthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt8=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, sixthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas8=firstAccountReceipt8.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt8.tx)).gasPrice);
	   await timeout(5000);
	   const seventhAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:seventhAccount, value:arbitratorFee});
	   const seventhAccountGas4=seventhAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt4.tx)).gasPrice);
	   await timeout(10000);
	   const secondAccountReceipt5=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:secondAccount, value:arbitratorFee});
	   const secondAccountGas5=secondAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt5.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt9=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, thirdAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas9=firstAccountReceipt9.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt9.tx)).gasPrice);
	   await timeout(5000);
	   const fourthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fourthAccount, value:arbitratorFee});
	   const fourthAccountGas4=fourthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt10=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, fifthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas10=firstAccountReceipt10.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt10.tx)).gasPrice);
	   await timeout(5000);
	   const sixthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:sixthAccount, value:arbitratorFeeIncreased});
	   const sixthAccountGas4=sixthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt11=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, seventhAccount,{from:firstAccount, value:arbitratorFeeIncreased});
	   const firstAccountGas11=firstAccountReceipt11.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt11.tx)).gasPrice);
	   await timeout(3000);
	   const disputesecond=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,secondindexoffer);
	   const disputethird=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,thirdindexoffer);
	   const disputefourth=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fourthindexoffer);
	   const disputefifth=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fifthindexoffer);
	   const disputesixth=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,sixthindexoffer);
	   const disputeseventh=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,seventhindexoffer);
	   await timeout(2000);
	   const thirdAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://stellar.org",{from:thirdAccount});
	   const thirdAccountGas5=thirdAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt12=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,thirdAccount,"https://neo.org",{from:firstAccount});
	   const firstAccountGas12=await firstAccountReceipt12.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt12.tx)).gasPrice);
	   await timeout(2000);
	   const fourthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://bitcoin.org",{from:fourthAccount});
	   const fourthAccountGas5=fourthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt13=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,fourthAccount,"https://ethereum.org",{from:firstAccount});
	   const firstAccountGas13=await firstAccountReceipt13.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt13.tx)).gasPrice);
	   await timeout(3000);
	   const fifthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://dash.org",{from:fifthAccount});
	   const fifthAccountGas5=fifthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt14=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,fifthAccount,"https://getmonero.org",{from:firstAccount});
	   const firstAccountGas14=await firstAccountReceipt14.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt14.tx)).gasPrice);
	   await timeout(2000);
	   const sixthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://z.cash",{from:sixthAccount});
	   const sixthAccountGas5=sixthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt15=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,sixthAccount,"https://litecoin.org",{from:firstAccount});
	   const firstAccountGas15=await firstAccountReceipt15.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt15.tx)).gasPrice);
	   await timeout(2000);
	   const seventhAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://eos.io",{from:seventhAccount});
	   const seventhAccountGas5=seventhAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt16=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,seventhAccount,"https://cardano.org",{from:firstAccount});
	   const firstAccountGas16=await firstAccountReceipt16.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt16.tx)).gasPrice);
	   await timeout(3000);
	   const secondDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,secondindexoffer);
	   const thirdDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,thirdindexoffer);
	   const fourthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fourthindexoffer);
	   const fifthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fifthindexoffer);
	   const sixthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,sixthindexoffer);
	   const seventhDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,seventhindexoffer);
	   const arbitratorAccount=accounts[9];
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(secondDisputeId,1,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount}); 
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(thirdDisputeId,2,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(fourthDisputeId,2,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(fifthDisputeId,1,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(sixthDisputeId,0,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(seventhDisputeId,0,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   await timeout(50000);
	   const serviceFeeAnte=await InstanceStoragePuzzles.getFeeBalance.call();
	   const arbitratorBalanceAnte=await web3.eth.getBalance(arbitratorAccount);
	   const arbitratorAccountReceipt=await InstanceAutoAppealableArbitrator.executeRuling(secondDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas=arbitratorAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt2=await InstanceAutoAppealableArbitrator.executeRuling(thirdDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas2=arbitratorAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt3=await InstanceAutoAppealableArbitrator.executeRuling(fourthDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas3=arbitratorAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt3.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt4=await InstanceAutoAppealableArbitrator.executeRuling(fifthDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas4=arbitratorAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt4.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt5=await InstanceAutoAppealableArbitrator.executeRuling(sixthDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas5=arbitratorAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt5.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt6=await InstanceAutoAppealableArbitrator.executeRuling(seventhDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas6=arbitratorAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt6.tx)).gasPrice);
	   await timeout(2000);
	   const serviceFee=await InstanceStoragePuzzles.getFeeBalance.call()-serviceFeeAnte;
	   const upgradeServiceFee=web3.utils.toBN(secondFee).add(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(fourthFee)).add(web3.utils.toBN(fifthFee)).add(web3.utils.toBN(sixthFee)).add(web3.utils.toBN(seventhFee));
	   assert.equal(serviceFee,upgradeServiceFee, "wrong fee");
	   const upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(firstAccountGas3)).sub(web3.utils.toBN(firstAccountGas4)).sub(web3.utils.toBN(firstAccountGas5)).sub(web3.utils.toBN(firstAccountGas6)).sub(web3.utils.toBN(firstAccountGas7)).sub(web3.utils.toBN(firstAccountGas8)).sub(web3.utils.toBN(firstAccountGas9)).sub(web3.utils.toBN(firstAccountGas10)).sub(web3.utils.toBN(firstAccountGas11)).sub(web3.utils.toBN(firstAccountGas12)).sub(web3.utils.toBN(firstAccountGas13)).sub(web3.utils.toBN(firstAccountGas14)).sub(web3.utils.toBN(firstAccountGas15)).sub(web3.utils.toBN(firstAccountGas16)).sub(web3.utils.toBN(secondexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).sub(web3.utils.toBN(arbitratorFee)).add(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(web3.utils.toWei("0.8","ether"))).sub(web3.utils.toBN(fourthFee)).sub(web3.utils.toBN(fifthexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("0.4","ether"))).sub(web3.utils.toBN(arbitratorFee)).sub(web3.utils.toBN(sixthFee/2)).sub(web3.utils.toBN(arbitratorFee/2)).sub(web3.utils.toBN(seventhFee/2)).sub(web3.utils.toBN(arbitratorFee/2));
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");
	   const upgradeamountsecond=web3.utils.toBN(secondAccountBalance).sub(web3.utils.toBN(secondAccountGas)).sub(web3.utils.toBN(secondAccountGas2)).sub(web3.utils.toBN(secondAccountGas3)).sub(web3.utils.toBN(secondAccountGas4)).sub(web3.utils.toBN(secondAccountGas5)).add(web3.utils.toBN(secondexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.5","ether"))).sub(web3.utils.toBN(secondFee));
	   assert.equal(await web3.eth.getBalance(secondAccount),upgradeamountsecond, "Second account amount wrong");
	   const upgradeamountthird=web3.utils.toBN(thirdAccountBalance).sub(web3.utils.toBN(thirdAccountGas)).sub(web3.utils.toBN(thirdAccountGas2)).sub(web3.utils.toBN(thirdAccountGas3)).sub(web3.utils.toBN(thirdAccountGas4)).sub(web3.utils.toBN(thirdAccountGas5)).sub(web3.utils.toBN(web3.utils.toWei("0.3","ether"))).sub(web3.utils.toBN(arbitratorFee));
	   assert.equal(await web3.eth.getBalance(thirdAccount),upgradeamountthird, "Third account amount wrong");
	   const upgradeamountfourth=web3.utils.toBN(fourthAccountBalance).sub(web3.utils.toBN(fourthAccountGas)).sub(web3.utils.toBN(fourthAccountGas2)).sub(web3.utils.toBN(fourthAccountGas3)).sub(web3.utils.toBN(fourthAccountGas4)).sub(web3.utils.toBN(fourthAccountGas5)).sub(web3.utils.toBN(web3.utils.toWei("0.8","ether"))).sub(web3.utils.toBN(arbitratorFee));
	   assert.equal(await web3.eth.getBalance(fourthAccount),upgradeamountfourth, "Fourth account amount wrong");
	   const upgradeamountfifth=web3.utils.toBN(fifthAccountBalance).sub(web3.utils.toBN(fifthAccountGas)).sub(web3.utils.toBN(fifthAccountGas2)).sub(web3.utils.toBN(fifthAccountGas3)).sub(web3.utils.toBN(fifthAccountGas4)).sub(web3.utils.toBN(fifthAccountGas5)).add(web3.utils.toBN(fifthexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("0.4","ether"))).sub(web3.utils.toBN(fifthFee));
	   assert.equal(await web3.eth.getBalance(fifthAccount),upgradeamountfifth, "Fifth account amount wrong");
	   const upgradeamountsixth=web3.utils.toBN(sixthAccountBalance).sub(web3.utils.toBN(sixthAccountGas)).sub(web3.utils.toBN(sixthAccountGas2)).sub(web3.utils.toBN(sixthAccountGas3)).sub(web3.utils.toBN(sixthAccountGas4)).sub(web3.utils.toBN(sixthAccountGas5)).sub(web3.utils.toBN(sixthFee/2)).sub(web3.utils.toBN(arbitratorFee/2))
	   assert.equal(await web3.eth.getBalance(sixthAccount),upgradeamountsixth, "Sixth account amount wrong");
	   const upgradeamountseventh=web3.utils.toBN(seventhAccountBalance).sub(web3.utils.toBN(seventhAccountGas)).sub(web3.utils.toBN(seventhAccountGas2)).sub(web3.utils.toBN(seventhAccountGas3)).sub(web3.utils.toBN(seventhAccountGas4)).sub(web3.utils.toBN(seventhAccountGas5)).sub(web3.utils.toBN(seventhFee/2)).sub(web3.utils.toBN(arbitratorFee/2))
	   assert.equal(await web3.eth.getBalance(seventhAccount),upgradeamountseventh, "Seventh account amount wrong");
	   const DaoAccount=accounts[0];
	   const addressStorage= InstanceStoragePuzzles.address;
	   await InstanceStoragePuzzles.withdrawFee(DaoAccount, await InstanceStoragePuzzles.getFeeBalance.call(), {from:DaoAccount});
	   assert.equal(await web3.eth.getBalance(addressStorage) ,0, "wrong balance fee");
	   const addressArbitrator=InstanceAutoAppealableArbitrator.address;
	   assert.equal(await web3.eth.getBalance(addressArbitrator) ,0, "wrong arbitrator contract balance fee");
	   const arbitratorBalanceFee=web3.utils.toBN(arbitratorBalanceAnte).sub(web3.utils.toBN(arbitratorAccountGas)).sub(web3.utils.toBN(arbitratorAccountGas2)).sub(web3.utils.toBN(arbitratorAccountGas3)).sub(web3.utils.toBN(arbitratorAccountGas4)).sub(web3.utils.toBN(arbitratorAccountGas5)).sub(web3.utils.toBN(arbitratorAccountGas6)).add(web3.utils.toBN(6*arbitratorFee));
	   assert.equal(await web3.eth.getBalance(arbitratorAccount), arbitratorBalanceFee, "wrong arbitrator account balance fee");
	   const addressArbitrable=InstanceLogicalPuzzlesArbitrable.address;
	   assert.equal(await web3.eth.getBalance(addressArbitrable), 0, "wrong arbitrable contract balance");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
		 const eventsPuzzlesInitialization=await InstanceLogicalPuzzlesInitialization.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesWithdraw=await InstanceLogicalPuzzlesWithdraw.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
		 console.log(eventsPuzzlesInitialization);
	     console.log(eventsPuzzlesWithdraw);
	   }
	});
	
	it("game sumbitted and offers, parties accept dispute with appeal", async () => {
	   const InstanceAutoAppealableArbitrator= await AutoAppealableArbitrator.deployed();
	   const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1]; //account that create game
	   const secret=await web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt=await InstanceLogicalPuzzlesCreation.proposeGame("Rebus2","http://gazzetta.it",0,[web3.utils.toWei("10","ether"),web3.utils.toWei("1","ether"),7],[15,30],150,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("30","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
	   await timeout(1000);
	   const secondAccount=accounts[2]; //account with right solution that will win dispute
	   const secondAccountBalance=await web3.eth.getBalance(secondAccount);
	   const secondAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:secondAccount,value:web3.utils.toWei("5","ether")});
	   const secondAccountGas=secondAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt.tx)).gasPrice);
	   const secondindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,secondAccount,{from:secondAccount});
	   const secondexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,secondindexoffer,{from:secondAccount});
	   const secondFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,secondindexoffer,{from:secondAccount});
	   assert.equal(secondexpectedwin,web3.utils.toWei("5","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex)) /100,"wrong expected win");
	   assert.equal(secondFee,secondexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const thirdAccount=accounts[3]; //account with wrong solution that will lose dispute
	   const thirdAccountBalance=await web3.eth.getBalance(thirdAccount);
	   const thirdAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:thirdAccount,value:web3.utils.toWei("3","ether")});
	   const thirdAccountGas=thirdAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt.tx)).gasPrice);
	   const thirdindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,thirdAccount,{from:thirdAccount});
	   const thirdexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   const thirdFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   assert.equal(thirdexpectedwin,web3.utils.toWei("3","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(thirdFee,thirdexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fourthAccount=accounts[4]; //account with right solution that will lose dispute
	   const fourthAccountBalance=await web3.eth.getBalance(fourthAccount);
	   const fourthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fourthAccount,value:web3.utils.toWei("8","ether")});
	   const fourthAccountGas=fourthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt.tx)).gasPrice);
	   const fourthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fourthAccount,{from:fourthAccount});
	   const fourthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   const fourthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   assert.equal(fourthexpectedwin,web3.utils.toWei("8","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fourthFee,fourthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fifthAccount=accounts[5]; //account with wrong solution that will win dispute
	   const fifthAccountBalance=await web3.eth.getBalance(fifthAccount);
	   const fifthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fifthAccount,value:web3.utils.toWei("4","ether")});
	   const fifthAccountGas=fifthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt.tx)).gasPrice);
	   const fifthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fifthAccount,{from:fifthAccount});
	   const fifthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   const fifthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   assert.equal(fifthexpectedwin,web3.utils.toWei("4","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fifthFee,fifthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const sixthAccount=accounts[6]; //account with right solution and not winner dispute
	   const sixthAccountBalance=await web3.eth.getBalance(sixthAccount);
	   const sixthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:sixthAccount,value:web3.utils.toWei("7","ether")});
	   const sixthAccountGas=sixthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt.tx)).gasPrice);
	   const sixthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,sixthAccount,{from:sixthAccount});
	   const sixthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,sixthindexoffer,{from:sixthAccount});
	   const sixthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,sixthindexoffer,{from:sixthAccount});
	   assert.equal(sixthexpectedwin,web3.utils.toWei("7","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(sixthFee,sixthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const seventhAccount=accounts[7]; //account with wrong solution and not winner dispute
	   const seventhAccountBalance=await web3.eth.getBalance(seventhAccount);
	   const seventhAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:seventhAccount,value:web3.utils.toWei("6","ether")});
	   const seventhAccountGas=seventhAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt.tx)).gasPrice);
	   const seventhindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,seventhAccount,{from:seventhAccount});
	   const seventhexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,seventhindexoffer,{from:seventhAccount});
	   const seventhFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,seventhindexoffer,{from:seventhAccount});
	   assert.equal(seventhexpectedwin,web3.utils.toWei("6","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(seventhFee,seventhexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(9000);
	   await timeout (5000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   const firstAccountReceipt3=await InstanceLogicalPuzzlesCreation.createGame(gameindex,"https://wikipedia.it",{from:firstAccount});
	   const firstAccountGas3=firstAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt3.tx)).gasPrice);
	   await timeout(10000);
	   const secondsecret=await web3.utils.keccak256("mypwdsecond");
	   const secondAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(secondsecret,solution),{from:secondAccount});
	   const secondAccountGas2=secondAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const thirdsecret=await web3.utils.keccak256("mypwdthird");
	   const thirdsolution="This is third wrong solution"; //wrong solution
	   const thirdAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(thirdsecret,thirdsolution),{from:thirdAccount});
	   const thirdAccountGas2=thirdAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt2.tx)).gasPrice);
	   await timeout(3000);
	   const fourthsecret=await web3.utils.keccak256("mypwdfourth");
	   const fourthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fourthsecret,solution),{from:fourthAccount});
	   const fourthAccountGas2=fourthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const fifthsecret=await web3.utils.keccak256("mypwdfifth");
	   const fifthsolution="This is fifth wrong solution"; //wrong solution
	   const fifthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fifthsecret,fifthsolution),{from:fifthAccount});
	   const fifthAccountGas2=fifthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt2.tx)).gasPrice);
	   await timeout(3000);
	   const sixthsecret=await web3.utils.keccak256("mypwdsixth");
	   const sixthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(sixthsecret,solution),{from:sixthAccount});
	   const sixthAccountGas2=sixthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const seventhsecret=await web3.utils.keccak256("mypwdseventh");
	   const seventhsolution="This is seventh wrong solution"; //wrong solution
	   const seventhAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(seventhsecret,seventhsolution),{from:seventhAccount});
	   const seventhAccountGas2=seventhAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt2.tx)).gasPrice);
	   await timeout(8000);
	   await timeout(4000);
	   const secondAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,secondsecret,{from:secondAccount});
	   const secondAccountGas3=secondAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt3.tx)).gasPrice);
	   const secondAccountReceipt4=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://tron.network",{from:secondAccount});
	   const secondAccountGas4=secondAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt4.tx)).gasPrice);
	   await timeout(3000);
	   const thirdAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,thirdsolution,thirdsecret,{from:thirdAccount});
	   const thirdAccountGas3=thirdAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const fourthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,fourthsecret,{from:fourthAccount});
	   const fourthAccountGas3=fourthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const fifthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,fifthsolution,fifthsecret,{from:fifthAccount});
	   const fifthAccountGas3=fifthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt3.tx)).gasPrice);
	   await timeout(3000);
	   const sixthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,sixthsecret,{from:sixthAccount});
	   const sixthAccountGas3=sixthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt3.tx)).gasPrice);
	   await timeout(4000);
	   const seventhAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,seventhsolution,seventhsecret,{from:seventhAccount});
	   const seventhAccountGas3=seventhAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt3.tx)).gasPrice);
	   await timeout(8000);
	   await timeout(15000);
	   const firstAccountReceipt4=await InstanceLogicalPuzzlesCreation.submitSolutionCreator(gameindex,solution,secret,{from:firstAccount});
	   const firstAccountGas4=firstAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt4.tx)).gasPrice);
	   const firstAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,secondAccount,"https://ripple.com",{from:firstAccount});
	   const firstAccountGas5=firstAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt5.tx)).gasPrice);
	   await timeout(10000);  
	   await timeout(3000);
	   var arbitratorExtraData=await InstanceStoragePuzzles.getarbitratorExtraData.call();
	   if (arbitratorExtraData==null) {
		   arbitratorExtraData="0x";
	   }
	   var arbitratorFee= await InstanceAutoAppealableArbitrator.arbitrationCost.call(arbitratorExtraData);
	   var arbitratorFeeIncreased=(web3.utils.toBN(arbitratorFee)).add(web3.utils.toBN(web3.utils.toWei("0.1","ether")));
	   const firstAccountReceipt6=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, secondAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas6=firstAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt6.tx)).gasPrice);
	   await timeout(5000);
	   const thirdAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:thirdAccount, value:arbitratorFee});
	   const thirdAccountGas4=thirdAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt7=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, fourthAccount,{from:firstAccount, value:arbitratorFeeIncreased});
	   const firstAccountGas7=firstAccountReceipt7.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt7.tx)).gasPrice);
	   await timeout(5000);
	   const fifthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fifthAccount, value:arbitratorFeeIncreased});
	   const fifthAccountGas4=fifthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt8=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, sixthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas8=firstAccountReceipt8.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt8.tx)).gasPrice);
	   await timeout(5000);
	   const seventhAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:seventhAccount, value:arbitratorFee});
	   const seventhAccountGas4=seventhAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt4.tx)).gasPrice);
	   await timeout(10000);
	   const secondAccountReceipt5=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:secondAccount, value:arbitratorFee});
	   const secondAccountGas5=secondAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt5.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt9=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, thirdAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas9=firstAccountReceipt9.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt9.tx)).gasPrice);
	   await timeout(5000);
	   const fourthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fourthAccount, value:arbitratorFee});
	   const fourthAccountGas4=fourthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt10=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, fifthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas10=firstAccountReceipt10.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt10.tx)).gasPrice);
	   await timeout(5000);
	   const sixthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:sixthAccount, value:arbitratorFeeIncreased});
	   const sixthAccountGas4=sixthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt11=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, seventhAccount,{from:firstAccount, value:arbitratorFeeIncreased});
	   const firstAccountGas11=firstAccountReceipt11.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt11.tx)).gasPrice);
	   await timeout(3000);
	   const secondDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,secondindexoffer);
	   const thirdDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,thirdindexoffer);
	   const fourthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fourthindexoffer);
	   const fifthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fifthindexoffer);
	   const sixthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,sixthindexoffer);
	   const seventhDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,seventhindexoffer);
	   await timeout(2000);
	   const thirdAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://stellar.org",{from:thirdAccount});
	   const thirdAccountGas5=thirdAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt12=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,thirdAccount,"https://neo.org",{from:firstAccount});
	   const firstAccountGas12=await firstAccountReceipt12.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt12.tx)).gasPrice);
	   await timeout(2000);
	   const fourthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://bitcoin.org",{from:fourthAccount});
	   const fourthAccountGas5=fourthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt13=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,fourthAccount,"https://ethereum.org",{from:firstAccount});
	   const firstAccountGas13=await firstAccountReceipt13.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt13.tx)).gasPrice);
	   await timeout(3000);
	   const fifthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://dash.org",{from:fifthAccount});
	   const fifthAccountGas5=fifthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt14=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,fifthAccount,"https://getmonero.org",{from:firstAccount});
	   const firstAccountGas14=await firstAccountReceipt14.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt14.tx)).gasPrice);
	   await timeout(2000);
	   const sixthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://z.cash",{from:sixthAccount});
	   const sixthAccountGas5=sixthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt15=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,sixthAccount,"https://litecoin.org",{from:firstAccount});
	   const firstAccountGas15=await firstAccountReceipt15.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt15.tx)).gasPrice);
	   await timeout(2000);
	   const seventhAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://eos.io",{from:seventhAccount});
	   const seventhAccountGas5=seventhAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(seventhAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt16=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,seventhAccount,"https://cardano.org",{from:firstAccount});
	   const firstAccountGas16=await firstAccountReceipt16.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt16.tx)).gasPrice);
	   await timeout(3000);
	   const arbitratorAccount=accounts[9];
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(secondDisputeId,1,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount}); 
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(thirdDisputeId,2,web3.utils.toWei("0.5","ether"),50,{from:arbitratorAccount}); 
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(fourthDisputeId,2,web3.utils.toWei("0.9","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(fifthDisputeId,1,web3.utils.toWei("0.7","ether"),50,{from:arbitratorAccount});
 	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(sixthDisputeId,0,web3.utils.toWei("0.9","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(seventhDisputeId,0,web3.utils.toWei("0.5","ether"),50,{from:arbitratorAccount});
	   await timeout(10000);
	   const appealcost= await InstanceAutoAppealableArbitrator.appealCost.call(secondDisputeId,arbitratorExtraData);
	   const firstAccountReceipt17=await InstanceLogicalPuzzlesArbitrable.appealCreator(gameindex, secondAccount,{from:firstAccount, value: appealcost });
	   const firstAccountGas17=await firstAccountReceipt17.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt17.tx)).gasPrice);
	   await timeout(3000);
	   const appealcost1= await InstanceAutoAppealableArbitrator.appealCost.call(thirdDisputeId,arbitratorExtraData);
	   const appealcost1Increased=(web3.utils.toBN(appealcost1)).add(web3.utils.toBN(web3.utils.toWei("0.2","ether")));
	   const thirdAccountReceipt6=await InstanceLogicalPuzzlesArbitrable.appealPlayer(gameindex,{from:thirdAccount, value: appealcost1Increased    });  
	   const thirdAccountGas6=await thirdAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt6.tx)).gasPrice);
	   await timeout(3000);
	   const appealcost2= await InstanceAutoAppealableArbitrator.appealCost.call(fourthDisputeId,arbitratorExtraData);
	   const appealcost2Increased=(web3.utils.toBN(appealcost2)).add(web3.utils.toBN(web3.utils.toWei("0.1","ether")));
	   const fourthAccountReceipt6=await InstanceLogicalPuzzlesArbitrable.appealPlayer(gameindex,{from:fourthAccount, value: appealcost2Increased});
	   const fourthAccountGas6=await fourthAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt6.tx)).gasPrice);
	   await timeout(3000);
	   const appealcost3= await InstanceAutoAppealableArbitrator.appealCost.call(fifthDisputeId,arbitratorExtraData);
	   const firstAccountReceipt18=await InstanceLogicalPuzzlesArbitrable.appealCreator(gameindex,fifthAccount,{from:firstAccount, value: appealcost3});
	   const firstAccountGas18=await firstAccountReceipt18.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt18.tx)).gasPrice);
	   await timeout(3000);
	   const appealcost4= await InstanceAutoAppealableArbitrator.appealCost.call(sixthDisputeId,arbitratorExtraData);
	   const sixthAccountReceipt6=await InstanceLogicalPuzzlesArbitrable.appealPlayer(gameindex,{from:sixthAccount, value: appealcost4});
	   const sixthAccountGas6=await sixthAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt6.tx)).gasPrice);
	   await timeout(3000);
	   const appealcost5= await InstanceAutoAppealableArbitrator.appealCost.call(seventhDisputeId,arbitratorExtraData);
	   const appealcost5Increased=(web3.utils.toBN(appealcost5)).add(web3.utils.toBN(web3.utils.toWei("0.25","ether")));
	   const firstAccountReceipt19=await InstanceLogicalPuzzlesArbitrable.appealCreator(gameindex,seventhAccount,{from:firstAccount, value:appealcost5Increased});
	   const firstAccountGas19=await firstAccountReceipt19.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt19.tx)).gasPrice);
	   await timeout(5000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(secondDisputeId,2,web3.utils.toWei("0.7","ether"),25,{from:arbitratorAccount}); 
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(thirdDisputeId,0,web3.utils.toWei("0.7","ether"),25,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(fourthDisputeId,2,web3.utils.toWei("0.7","ether"),25,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(fifthDisputeId,0,web3.utils.toWei("0.7","ether"),25,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(sixthDisputeId,1,web3.utils.toWei("0.7","ether"),25,{from:arbitratorAccount});
	   await timeout(2000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(seventhDisputeId,1,web3.utils.toWei("0.7","ether"),25,{from:arbitratorAccount});
	   await timeout(30000); 
	   const serviceFeeAnte=await InstanceStoragePuzzles.getFeeBalance.call();
	   const arbitratorBalanceAnte=await web3.eth.getBalance(arbitratorAccount);
	   const arbitratorAccountReceipt=await InstanceAutoAppealableArbitrator.executeRuling(secondDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas=arbitratorAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt2=await InstanceAutoAppealableArbitrator.executeRuling(thirdDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas2=arbitratorAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt3=await InstanceAutoAppealableArbitrator.executeRuling(fourthDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas3=arbitratorAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt3.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt4=await InstanceAutoAppealableArbitrator.executeRuling(fifthDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas4=arbitratorAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt4.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt5=await InstanceAutoAppealableArbitrator.executeRuling(sixthDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas5=arbitratorAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt5.tx)).gasPrice);
	   await timeout(2000);
	   const arbitratorAccountReceipt6=await InstanceAutoAppealableArbitrator.executeRuling(seventhDisputeId,{from:arbitratorAccount});
	   const arbitratorAccountGas6=arbitratorAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(arbitratorAccountReceipt6.tx)).gasPrice);
	   await timeout(2000);
	   const serviceFee=await InstanceStoragePuzzles.getFeeBalance.call()-serviceFeeAnte;
	   const upgradeServiceFee=web3.utils.toBN(secondFee).add(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(fourthFee)).add(web3.utils.toBN(fifthFee)).add(web3.utils.toBN(sixthFee)).add(web3.utils.toBN(seventhFee));
	   assert.equal(serviceFee,upgradeServiceFee, "wrong fee");
	   const upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(firstAccountGas3)).sub(web3.utils.toBN(firstAccountGas4)).sub(web3.utils.toBN(firstAccountGas5)).sub(web3.utils.toBN(firstAccountGas6)).sub(web3.utils.toBN(firstAccountGas7)).sub(web3.utils.toBN(firstAccountGas8)).sub(web3.utils.toBN(firstAccountGas9)).sub(web3.utils.toBN(firstAccountGas10)).sub(web3.utils.toBN(firstAccountGas11)).sub(web3.utils.toBN(firstAccountGas12)).sub(web3.utils.toBN(firstAccountGas13)).sub(web3.utils.toBN(firstAccountGas14)).sub(web3.utils.toBN(firstAccountGas15)).sub(web3.utils.toBN(firstAccountGas16)).sub(web3.utils.toBN(firstAccountGas17)).sub(web3.utils.toBN(firstAccountGas18)).sub(web3.utils.toBN(firstAccountGas19)).add(web3.utils.toBN(web3.utils.toWei("5","ether"))).sub(web3.utils.toBN(secondFee)).sub(web3.utils.toBN(appealcost)).sub(web3.utils.toBN(thirdFee/2)).sub(web3.utils.toBN(arbitratorFee/2)).add(web3.utils.toBN(web3.utils.toWei("8","ether"))).sub(web3.utils.toBN(fourthFee)).sub(web3.utils.toBN(fifthFee/2)).sub(web3.utils.toBN(arbitratorFee/2)).sub(web3.utils.toBN(appealcost3)).sub(web3.utils.toBN(sixthexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("7","ether"))).sub(web3.utils.toBN(arbitratorFee)).sub(web3.utils.toBN(seventhexpectedwin)).add(web3.utils.toBN(web3.utils.toWei("6","ether"))).sub(web3.utils.toBN(arbitratorFee)).sub(web3.utils.toBN(appealcost5));                          
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");
	   const upgradeamountsecond=web3.utils.toBN(secondAccountBalance).sub(web3.utils.toBN(secondAccountGas)).sub(web3.utils.toBN(secondAccountGas2)).sub(web3.utils.toBN(secondAccountGas3)).sub(web3.utils.toBN(secondAccountGas4)).sub(web3.utils.toBN(secondAccountGas5)).sub(web3.utils.toBN(web3.utils.toWei("5","ether"))).sub(web3.utils.toBN(arbitratorFee));
	   assert.equal(await web3.eth.getBalance(secondAccount),upgradeamountsecond, "Second account amount wrong");
	   const upgradeamountthird=web3.utils.toBN(thirdAccountBalance).sub(web3.utils.toBN(thirdAccountGas)).sub(web3.utils.toBN(thirdAccountGas2)).sub(web3.utils.toBN(thirdAccountGas3)).sub(web3.utils.toBN(thirdAccountGas4)).sub(web3.utils.toBN(thirdAccountGas5)).sub(web3.utils.toBN(thirdAccountGas6)).sub(web3.utils.toBN(thirdFee/2)).sub(web3.utils.toBN(arbitratorFee/2)).sub(web3.utils.toBN(appealcost1));
	   assert.equal(await web3.eth.getBalance(thirdAccount),upgradeamountthird, "Third account amount wrong");
	   const upgradeamountfourth=web3.utils.toBN(fourthAccountBalance).sub(web3.utils.toBN(fourthAccountGas)).sub(web3.utils.toBN(fourthAccountGas2)).sub(web3.utils.toBN(fourthAccountGas3)).sub(web3.utils.toBN(fourthAccountGas4)).sub(web3.utils.toBN(fourthAccountGas5)).sub(web3.utils.toBN(fourthAccountGas6)).sub(web3.utils.toBN(web3.utils.toWei("8","ether"))).sub(web3.utils.toBN(arbitratorFee)).sub(web3.utils.toBN(appealcost2));
	   assert.equal(await web3.eth.getBalance(fourthAccount),upgradeamountfourth, "Fourth account amount wrong");
	   const upgradeamountfifth=web3.utils.toBN(fifthAccountBalance).sub(web3.utils.toBN(fifthAccountGas)).sub(web3.utils.toBN(fifthAccountGas2)).sub(web3.utils.toBN(fifthAccountGas3)).sub(web3.utils.toBN(fifthAccountGas4)).sub(web3.utils.toBN(fifthAccountGas5)).sub(web3.utils.toBN(fifthFee/2)).sub(web3.utils.toBN(arbitratorFee/2));
	   assert.equal(await web3.eth.getBalance(fifthAccount),upgradeamountfifth, "Fifth account amount wrong");
	   const upgradeamountsixth=web3.utils.toBN(sixthAccountBalance).sub(web3.utils.toBN(sixthAccountGas)).sub(web3.utils.toBN(sixthAccountGas2)).sub(web3.utils.toBN(sixthAccountGas3)).sub(web3.utils.toBN(sixthAccountGas4)).sub(web3.utils.toBN(sixthAccountGas5)).sub(web3.utils.toBN(sixthAccountGas6)).add(web3.utils.toBN(sixthexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("7","ether"))).sub(web3.utils.toBN(sixthFee)).sub(web3.utils.toBN(appealcost4));
	   assert.equal(await web3.eth.getBalance(sixthAccount),upgradeamountsixth, "Sixth account amount wrong");
	   const upgradeamountseventh=web3.utils.toBN(seventhAccountBalance).sub(web3.utils.toBN(seventhAccountGas)).sub(web3.utils.toBN(seventhAccountGas2)).sub(web3.utils.toBN(seventhAccountGas3)).sub(web3.utils.toBN(seventhAccountGas4)).sub(web3.utils.toBN(seventhAccountGas5)).add(web3.utils.toBN(seventhexpectedwin)).sub(web3.utils.toBN(web3.utils.toWei("6","ether"))).sub(web3.utils.toBN(seventhFee))
	   assert.equal(await web3.eth.getBalance(seventhAccount),upgradeamountseventh, "Seventh account amount wrong");
	   const DaoAccount=accounts[0];
	   const addressStorage= InstanceStoragePuzzles.address;
	   await InstanceStoragePuzzles.withdrawFee(DaoAccount, await InstanceStoragePuzzles.getFeeBalance.call(), {from:DaoAccount});
	   assert.equal(await web3.eth.getBalance(addressStorage) ,0, "wrong balance fee");
	   const addressArbitrator=InstanceAutoAppealableArbitrator.address;
	   assert.equal(await web3.eth.getBalance(addressArbitrator) ,0, "wrong arbitrator contract balance fee");
	   const arbitratorBalanceFee=web3.utils.toBN(arbitratorBalanceAnte).sub(web3.utils.toBN(arbitratorAccountGas)).sub(web3.utils.toBN(arbitratorAccountGas2)).sub(web3.utils.toBN(arbitratorAccountGas3)).sub(web3.utils.toBN(arbitratorAccountGas4)).sub(web3.utils.toBN(arbitratorAccountGas5)).sub(web3.utils.toBN(arbitratorAccountGas6)).add(web3.utils.toBN(6*arbitratorFee)).add(web3.utils.toBN(web3.utils.toWei("4.2","ether")));
	   assert.equal(await web3.eth.getBalance(arbitratorAccount), arbitratorBalanceFee , "wrong arbitrator account balance fee"); 
	   const addressArbitrable=InstanceLogicalPuzzlesArbitrable.address;
	   assert.equal(await web3.eth.getBalance(addressArbitrable), 0, "wrong arbitrable contract balance");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
		 const eventsPuzzlesInitialization=await InstanceLogicalPuzzlesInitialization.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesWithdraw=await InstanceLogicalPuzzlesWithdraw.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
		 console.log(eventsPuzzlesInitialization);
	     console.log(eventsPuzzlesWithdraw);
	   }
	});
	
	it("game sumbitted and offers, parties accept dispute but not rules by arbitrator", async () => {
	   const InstanceAutoAppealableArbitrator= await AutoAppealableArbitrator.deployed();
	   const InstanceStoragePuzzles = await  StoragePuzzles.deployed();
       const InstanceLogicalPuzzlesCreation = await LogicalPuzzlesCreation.deployed();
       const InstanceLogicalPuzzlesWithdraw =  await LogicalPuzzlesWithdraw.deployed();
       const InstanceLogicalPuzzlesArbitrable = await LogicalPuzzlesArbitrable.deployed();
       const InstanceLogicalPuzzlesInitialization = await LogicalPuzzlesInitialization.deployed();
       const InstanceLogicalPuzzlesDisputeWithdraw = await LogicalPuzzlesDisputeWithdraw.deployed();
	   const firstAccount=accounts[1]; //account that create game
	   const secret=await web3.utils.keccak256("mypwd");
	   const solution="This is the solution";
	   const firstAccountBalance=await web3.eth.getBalance(firstAccount);
	   const firstAccountReceipt=await InstanceLogicalPuzzlesCreation.proposeGame("Rebus2","http://gazzetta.it",0,[web3.utils.toWei("10","ether"),web3.utils.toWei("1","ether"),7],[15,30],150,web3.utils.soliditySha3(secret,solution),{from:firstAccount,value:web3.utils.toWei("30","ether")});
	   const firstAccountGas=firstAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt.tx)).gasPrice);
	   const gameindex = await InstanceStoragePuzzles.getGamesLength.call()-1;
	   function timeout(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
       }
	   await timeout(1000);
	   const secondAccount=accounts[2]; //account with right solution that withdraw player with no ruling
	   const secondAccountBalance=await web3.eth.getBalance(secondAccount);
	   const secondAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:secondAccount,value:web3.utils.toWei("5","ether")});
	   const secondAccountGas=secondAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt.tx)).gasPrice);
	   const secondindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,secondAccount,{from:secondAccount});
	   const secondexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,secondindexoffer,{from:secondAccount});
	   const secondFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,secondindexoffer,{from:secondAccount});
	   assert.equal(secondexpectedwin,web3.utils.toWei("5","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex)) /100,"wrong expected win");
	   assert.equal(secondFee,secondexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const thirdAccount=accounts[3]; //account with wrong solution that withdraw single creator with no ruling
	   const thirdAccountBalance=await web3.eth.getBalance(thirdAccount);
	   const thirdAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:thirdAccount,value:web3.utils.toWei("3","ether")});
	   const thirdAccountGas=thirdAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt.tx)).gasPrice);
	   const thirdindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,thirdAccount,{from:thirdAccount});
	   const thirdexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   const thirdFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,thirdindexoffer,{from:thirdAccount});
	   assert.equal(thirdexpectedwin,web3.utils.toWei("3","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(thirdFee,thirdexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fourthAccount=accounts[4]; //account with wrong solution that withdraw creator with no ruling
	   const fourthAccountBalance=await web3.eth.getBalance(fourthAccount);
	   const fourthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fourthAccount,value:web3.utils.toWei("8","ether")});
	   const fourthAccountGas=fourthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt.tx)).gasPrice);
	   const fourthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fourthAccount,{from:fourthAccount});
	   const fourthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   const fourthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fourthindexoffer,{from:fourthAccount});
	   assert.equal(fourthexpectedwin,web3.utils.toWei("8","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fourthFee,fourthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const fifthAccount=accounts[5]; //account with wrong solution that withdraw creator with no ruling
	   const fifthAccountBalance=await web3.eth.getBalance(fifthAccount);
	   const fifthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:fifthAccount,value:web3.utils.toWei("4","ether")});
	   const fifthAccountGas=fifthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt.tx)).gasPrice);
	   const fifthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,fifthAccount,{from:fifthAccount});
	   const fifthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   const fifthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,fifthindexoffer,{from:fifthAccount});
	   assert.equal(fifthexpectedwin,web3.utils.toWei("4","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(fifthFee,fifthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(1000);
	   const sixthAccount=accounts[6]; //account with right solution and not winner dispute
	   const sixthAccountBalance=await web3.eth.getBalance(sixthAccount);
	   const sixthAccountReceipt=await InstanceLogicalPuzzlesCreation.createOffer(gameindex,{from:sixthAccount,value:web3.utils.toWei("7","ether")});
	   const sixthAccountGas=sixthAccountReceipt.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt.tx)).gasPrice);
	   const sixthindexoffer=await InstanceStoragePuzzles.getOffersMapIndexOffer.call(gameindex,sixthAccount,{from:sixthAccount});
	   const sixthexpectedwin=await InstanceStoragePuzzles.getOfferExpectedWin.call(gameindex,sixthindexoffer,{from:sixthAccount});
	   const sixthFee=await InstanceStoragePuzzles.getOfferServiceFee.call(gameindex,sixthindexoffer,{from:sixthAccount});
	   assert.equal(sixthexpectedwin,web3.utils.toWei("7","ether")*(await InstanceStoragePuzzles.getGameQuote(gameindex))/100,"wrong expected win");
	   assert.equal(sixthFee,sixthexpectedwin*(await InstanceStoragePuzzles.getFeePercent())/10000,"wrong expected win");
	   await timeout(10000);
	   await timeout (5000);
	   const firstAccountReceipt2=await InstanceLogicalPuzzlesCreation.withdrawResidual(gameindex,{from:firstAccount});
	   const firstAccountGas2=firstAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   const firstAccountReceipt3=await InstanceLogicalPuzzlesCreation.createGame(gameindex,"https://wikipedia.it",{from:firstAccount});
	   const firstAccountGas3=firstAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt3.tx)).gasPrice);;
	   await timeout(10000);
	   const secondsecret=await web3.utils.keccak256("mypwdsecond");
	   const secondAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(secondsecret,solution),{from:secondAccount});
	   const secondAccountGas2=secondAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const thirdsecret=await web3.utils.keccak256("mypwdthird");
	   const thirdsolution="This is third wrong solution"; //wrong solution
	   const thirdAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(thirdsecret,thirdsolution),{from:thirdAccount});
	   const thirdAccountGas2=thirdAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt2.tx)).gasPrice);
	   await timeout(3000);
	   const fourthsecret=await web3.utils.keccak256("mypwdfourth");
	   const fourthsolution="This is fourth wrong solution"; //wrong solution
	   const fourthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fourthsecret,fourthsolution),{from:fourthAccount});
	   const fourthAccountGas2=fourthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt2.tx)).gasPrice);
	   await timeout(2000);
	   const fifthsecret=await web3.utils.keccak256("mypwdfifth");
	   const fifthsolution="This is fifth wrong solution"; //wrong solution
	   const fifthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(fifthsecret,fifthsolution),{from:fifthAccount});
	   const fifthAccountGas2=fifthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt2.tx)).gasPrice);
	   await timeout(3000);
	   const sixthsecret=await web3.utils.keccak256("mypwdsixth");
	   const sixthAccountReceipt2=await InstanceLogicalPuzzlesCreation.submitSolutionHash(gameindex,web3.utils.soliditySha3(sixthsecret,solution),{from:sixthAccount});
	   const sixthAccountGas2=sixthAccountReceipt2.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt2.tx)).gasPrice);
	   await timeout(10000);
	   await timeout(4000);
	   const secondAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,secondsecret,{from:secondAccount});
	   const secondAccountGas3=secondAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt3.tx)).gasPrice);
	   const secondAccountReceipt4=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://tron.network",{from:secondAccount});
	   const secondAccountGas4=secondAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const thirdAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,thirdsolution,thirdsecret,{from:thirdAccount});
	   const thirdAccountGas3=thirdAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt3.tx)).gasPrice);
	   await timeout(5000);
	   const fourthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,fourthsolution,fourthsecret,{from:fourthAccount});
	   const fourthAccountGas3=fourthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt3.tx)).gasPrice);
	   await timeout(5000);
	   const fifthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,fifthsolution,fifthsecret,{from:fifthAccount});
	   const fifthAccountGas3=fifthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt3.tx)).gasPrice);
	   await timeout(3000);
	   const sixthAccountReceipt3=await InstanceLogicalPuzzlesCreation.submitSolutionPlayer(gameindex,solution,sixthsecret,{from:sixthAccount});
	   const sixthAccountGas3=sixthAccountReceipt3.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt3.tx)).gasPrice);
	   await timeout(8000);
	   await timeout(15000);
	   const firstAccountReceipt4=await InstanceLogicalPuzzlesCreation.submitSolutionCreator(gameindex,solution,secret,{from:firstAccount});
	   const firstAccountGas4=firstAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt4.tx)).gasPrice);
	   const firstAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,secondAccount,"https://ripple.com",{from:firstAccount});
	   const firstAccountGas5=firstAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt5.tx)).gasPrice);
	   await timeout(10000);  
	   const arbitratorAccount=accounts[9];
	   await timeout(3000);
	   var arbitratorExtraData=await InstanceStoragePuzzles.getarbitratorExtraData.call();
	   if (arbitratorExtraData==null) {
		   arbitratorExtraData="0x";
	   }
	   var arbitratorFee= await InstanceAutoAppealableArbitrator.arbitrationCost.call(arbitratorExtraData);
	   var arbitratorFeeIncreased=(web3.utils.toBN(arbitratorFee)).add(web3.utils.toBN(web3.utils.toWei("0.1","ether")));
	   const firstAccountReceipt6=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, secondAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas6=firstAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt6.tx)).gasPrice);
	   await timeout(7000);
	   const thirdAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:thirdAccount, value:arbitratorFee});
	   const thirdAccountGas4=thirdAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt4.tx)).gasPrice);
	   await timeout(7000);
	   const fourthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fourthAccount, value:arbitratorFeeIncreased});
	   const fourthAccountGas4=fourthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt4.tx)).gasPrice);
	   await timeout(7000);
	   const fifthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:fifthAccount, value:arbitratorFeeIncreased});
	   const fifthAccountGas4=fifthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt4.tx)).gasPrice);
	   await timeout(7000);
	   const firstAccountReceipt7=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, sixthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas7=firstAccountReceipt7.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt7.tx)).gasPrice);
	   await timeout(3000);
	   const secondAccountReceipt5=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:secondAccount, value:arbitratorFee});
	   const secondAccountGas5=secondAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt5.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt8=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, thirdAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas8=firstAccountReceipt8.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt8.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt9=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex,fourthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas9=firstAccountReceipt9.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt9.tx)).gasPrice);
	   await timeout(5000);
	   const sixthAccountReceipt4=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByPlayer(gameindex,{from:sixthAccount, value:arbitratorFeeIncreased});
	   const sixthAccountGas4=sixthAccountReceipt4.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt4.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt10=await InstanceLogicalPuzzlesInitialization.payArbitrationFeeByCreator(gameindex, fifthAccount,{from:firstAccount, value:arbitratorFee});
	   const firstAccountGas10=firstAccountReceipt10.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt10.tx)).gasPrice);
	   await timeout(3000);
	   const secondDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,secondindexoffer);
	   const thirdDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,thirdindexoffer);
	   const fourthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fourthindexoffer);
	   const fifthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,fifthindexoffer);
	   const sixthDisputeId=await InstanceStoragePuzzles.getOfferDisputeId.call(gameindex,sixthindexoffer);
	   await timeout(2000);
	   const thirdAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://stellar.org",{from:thirdAccount});
	   const thirdAccountGas5=thirdAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(thirdAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt11=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,thirdAccount,"https://neo.org",{from:firstAccount});
	   const firstAccountGas11=await firstAccountReceipt11.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt11.tx)).gasPrice);
	   await timeout(2000);
	   const fourthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://bitcoin.org",{from:fourthAccount});
	   const fourthAccountGas5=fourthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(fourthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt12=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,fourthAccount,"https://ethereum.org",{from:firstAccount});
	   const firstAccountGas12=await firstAccountReceipt12.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt12.tx)).gasPrice);
	   await timeout(3000);
	   const fifthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://dash.org",{from:fifthAccount});
	   const fifthAccountGas5=fifthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(fifthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt13=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,fifthAccount,"https://getmonero.org",{from:firstAccount});
	   const firstAccountGas13=await firstAccountReceipt13.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt13.tx)).gasPrice);
	   await timeout(2000);
	   const sixthAccountReceipt5=await InstanceLogicalPuzzlesArbitrable.submitEvidencePlayer(gameindex,"https://z.cash",{from:sixthAccount});
	   const sixthAccountGas5=sixthAccountReceipt5.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt5.tx)).gasPrice);
	   await timeout(1000);
	   const firstAccountReceipt14=await InstanceLogicalPuzzlesArbitrable.submitEvidenceCreator(gameindex,sixthAccount,"https://litecoin.org",{from:firstAccount});
	   const firstAccountGas14=await firstAccountReceipt14.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt14.tx)).gasPrice);
	   await timeout(60000);
	   await InstanceAutoAppealableArbitrator.giveAppealableRuling(sixthDisputeId,2,web3.utils.toWei("0.9","ether"),50,{from:arbitratorAccount});
	   await timeout(2000);
	   const appealcost= await InstanceAutoAppealableArbitrator.appealCost.call(sixthDisputeId,arbitratorExtraData);
	   const sixthAccountReceipt6=await InstanceLogicalPuzzlesArbitrable.appealPlayer(gameindex,{from:sixthAccount, value: appealcost});
	   const sixthAccountGas6=await sixthAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt6.tx)).gasPrice);
	   await timeout(60000);
	   const serviceFeeAnte=await InstanceStoragePuzzles.getFeeBalance.call();
	   const arbitratorBalanceAnte=await web3.eth.getBalance(arbitratorAccount);
	   const secondAccountReceipt6=await InstanceLogicalPuzzlesDisputeWithdraw.WithdrawPlayerNoRuling(gameindex,{from:secondAccount});   
	   const secondAccountGas6=secondAccountReceipt6.receipt.gasUsed*((await web3.eth.getTransaction(secondAccountReceipt6.tx)).gasPrice);
	   await timeout(5000);
       const firstAccountReceipt15=await InstanceLogicalPuzzlesDisputeWithdraw.WithdrawCreatorNoRulingSingle(gameindex,thirdAccount,{from:firstAccount}); 
	   const firstAccountGas15=await firstAccountReceipt15.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt15.tx)).gasPrice);
	   await timeout(5000);
	   const firstAccountReceipt16=await InstanceLogicalPuzzlesDisputeWithdraw.WithdrawCreatorNoRuling(gameindex,{from:firstAccount});  
	   const firstAccountGas16=await firstAccountReceipt16.receipt.gasUsed*((await web3.eth.getTransaction(firstAccountReceipt16.tx)).gasPrice);
	   await timeout(60000);
	   const sixthAccountReceipt7=await InstanceLogicalPuzzlesDisputeWithdraw.WithdrawPlayerNoRuling(gameindex,{from:sixthAccount});   
	   const sixthAccountGas7=sixthAccountReceipt7.receipt.gasUsed*((await web3.eth.getTransaction(sixthAccountReceipt7.tx)).gasPrice);
	   await timeout(3000);
	   const serviceFee=await InstanceStoragePuzzles.getFeeBalance.call()-serviceFeeAnte;
	   const upgradeServiceFee=web3.utils.toBN(secondFee).add(web3.utils.toBN(thirdFee)).add(web3.utils.toBN(fourthFee)).add(web3.utils.toBN(fifthFee)).add(web3.utils.toBN(sixthFee));
	   assert.equal(serviceFee,upgradeServiceFee, "wrong fee");
	   const upgradeamountfirst=web3.utils.toBN(firstAccountBalance).sub(web3.utils.toBN(firstAccountGas)).sub(web3.utils.toBN(firstAccountGas2)).sub(web3.utils.toBN(firstAccountGas3)).sub(web3.utils.toBN(firstAccountGas4)).sub(web3.utils.toBN(firstAccountGas5)).sub(web3.utils.toBN(firstAccountGas6)).sub(web3.utils.toBN(firstAccountGas7)).sub(web3.utils.toBN(firstAccountGas8)).sub(web3.utils.toBN(firstAccountGas9)).sub(web3.utils.toBN(firstAccountGas10)).sub(web3.utils.toBN(firstAccountGas11)).sub(web3.utils.toBN(firstAccountGas12)).sub(web3.utils.toBN(firstAccountGas13)).sub(web3.utils.toBN(firstAccountGas14)).sub(web3.utils.toBN(firstAccountGas15)).sub(web3.utils.toBN(firstAccountGas16)).sub(web3.utils.toBN(secondFee/2)).sub(web3.utils.toBN(thirdFee/2)).sub(web3.utils.toBN(fourthFee/2)).sub(web3.utils.toBN(fifthFee/2)).sub(web3.utils.toBN(sixthFee/2)).sub(web3.utils.toBN(5*(arbitratorFee/2)));       
	   assert.equal(await web3.eth.getBalance(firstAccount),upgradeamountfirst, "First account amount wrong");
	   const upgradeamountsecond=web3.utils.toBN(secondAccountBalance).sub(web3.utils.toBN(secondAccountGas)).sub(web3.utils.toBN(secondAccountGas2)).sub(web3.utils.toBN(secondAccountGas3)).sub(web3.utils.toBN(secondAccountGas4)).sub(web3.utils.toBN(secondAccountGas5)).sub(web3.utils.toBN(secondAccountGas6)).sub(web3.utils.toBN(secondFee/2)).sub(web3.utils.toBN(arbitratorFee/2));
	   assert.equal(await web3.eth.getBalance(secondAccount),upgradeamountsecond, "Second account amount wrong");
	   const upgradeamountthird=web3.utils.toBN(thirdAccountBalance).sub(web3.utils.toBN(thirdAccountGas)).sub(web3.utils.toBN(thirdAccountGas2)).sub(web3.utils.toBN(thirdAccountGas3)).sub(web3.utils.toBN(thirdAccountGas4)).sub(web3.utils.toBN(thirdAccountGas5)).sub(web3.utils.toBN(thirdFee/2)).sub(web3.utils.toBN(arbitratorFee/2));
	   assert.equal(await web3.eth.getBalance(thirdAccount),upgradeamountthird, "Third account amount wrong");
	   const upgradeamountfourth=web3.utils.toBN(fourthAccountBalance).sub(web3.utils.toBN(fourthAccountGas)).sub(web3.utils.toBN(fourthAccountGas2)).sub(web3.utils.toBN(fourthAccountGas3)).sub(web3.utils.toBN(fourthAccountGas4)).sub(web3.utils.toBN(fourthAccountGas5)).sub(web3.utils.toBN(fourthFee/2)).sub(web3.utils.toBN(arbitratorFee/2));
	   assert.equal(await web3.eth.getBalance(fourthAccount),upgradeamountfourth, "Fourth account amount wrong");
	   const upgradeamountfifth=web3.utils.toBN(fifthAccountBalance).sub(web3.utils.toBN(fifthAccountGas)).sub(web3.utils.toBN(fifthAccountGas2)).sub(web3.utils.toBN(fifthAccountGas3)).sub(web3.utils.toBN(fifthAccountGas4)).sub(web3.utils.toBN(fifthAccountGas5)).sub(web3.utils.toBN(fifthFee/2)).sub(web3.utils.toBN(arbitratorFee/2));
	   assert.equal(await web3.eth.getBalance(fifthAccount),upgradeamountfifth, "Fifth account amount wrong");
	   const upgradeamountsixth=web3.utils.toBN(sixthAccountBalance).sub(web3.utils.toBN(sixthAccountGas)).sub(web3.utils.toBN(sixthAccountGas2)).sub(web3.utils.toBN(sixthAccountGas3)).sub(web3.utils.toBN(sixthAccountGas4)).sub(web3.utils.toBN(sixthAccountGas5)).sub(web3.utils.toBN(sixthAccountGas6)).sub(web3.utils.toBN(sixthAccountGas7)).sub(web3.utils.toBN(sixthFee/2)).sub(web3.utils.toBN(arbitratorFee/2)).sub(web3.utils.toBN(appealcost));
	   assert.equal(await web3.eth.getBalance(sixthAccount),upgradeamountsixth, "Sixth account amount wrong");
	   const DaoAccount=accounts[0];
	   const addressStorage= InstanceStoragePuzzles.address;
	   await InstanceStoragePuzzles.withdrawFee(DaoAccount, await InstanceStoragePuzzles.getFeeBalance.call(), {from:DaoAccount});
	   assert.equal(await web3.eth.getBalance(addressStorage) ,0, "wrong balance fee");
	   const addressArbitrator=InstanceAutoAppealableArbitrator.address;
	   assert.equal(await web3.eth.getBalance(addressArbitrator) ,web3.utils.toBN(5*arbitratorFee).add(web3.utils.toBN(appealcost)), "wrong arbitrator contract balance fee");
	   assert.equal(await web3.eth.getBalance(arbitratorAccount), arbitratorBalanceAnte , "wrong arbitrator account balance fee"); 
	   const addressArbitrable=InstanceLogicalPuzzlesArbitrable.address;
	   assert.equal(await web3.eth.getBalance(addressArbitrable), 0 , "wrong arbitrable contract balance");
	   const logFlag=false;
	   if (logFlag==true) {
	     const eventsPuzzlesCreation=await InstanceLogicalPuzzlesCreation.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesArbitrable=await InstanceLogicalPuzzlesArbitrable.getPastEvents("allEvents",{fromBlock: 0});
		 const eventsPuzzlesInitialization=await InstanceLogicalPuzzlesInitialization.getPastEvents("allEvents",{fromBlock: 0});
	     const eventsPuzzlesWithdraw=await InstanceLogicalPuzzlesWithdraw.getPastEvents("allEvents",{fromBlock: 0});
	     console.log(eventsPuzzlesCreation);
	     console.log(eventsPuzzlesArbitrable);
		 console.log(eventsPuzzlesInitialization);
	     console.log(eventsPuzzlesWithdraw);
	   }
	});
	   
		
	   
	   
	   

	
	   
	  
	   
		
	
	
		
		
	   
	   
	   
});