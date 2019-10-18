pragma solidity ^0.5.0;

library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "sub operation not correct");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

contract StoragePuzzlesAbstract  {
    
    function AddGamesType (bool _gameActivated)  external;
    
    function SetGameType (bool _gameActivated, uint256 _gameTypeIndex)  external;
    
    function GetGameType (uint256 _gameTypeIndex) external view returns (bool);
    
    function GetGameTypeLength()  external view returns (uint256);
    
    function setMinimalJackpot (uint256 _minimalJackpot)  external;
    
    function getMinimalJackpot() external view returns(uint256);
    
    function setMaxTimeoutCreation (uint256 _maxTimeoutCreation)   external;
    
    function getMaxTimeoutCreation () external view returns(uint256);
    
    function setTimeoutPlayerSolution (uint256 _timeoutPlayerSolution)  external;
    
    function getTimeoutPlayerSolution () external view returns(uint256);
    
    function setTimeoutCreatorSolution (uint256 _timeoutCreatorSolution) external;
    
    function getTimeoutCreatorSolution () external view returns(uint256);
        
    function setTimeoutDisp (uint256 _timeoutDisp)  external;
    
    function getTimeoutDisp () external view returns(uint256);
    
    function setTimeoutRuling (uint256 _timeoutRuling)  external;
    
    function getTimeoutRuling () external view returns(uint256);
    
    function setFeePercent (uint256 _feePercent)  external;
    
    function getFeePercent() external view returns(uint256);
 
    function setArbitrator (address _arbitratorAddress, bytes calldata _arbitratorExtraData)  external;
    
    function getArbitratorAddress() external view returns(address);
    
    function getarbitratorExtraData() external view returns(bytes memory);
    
    function setFeeTimeout(uint256 _feeTimeout)  external;
    
    function getFeeTimeout() external view returns(uint256);
    
    function addLogicalContract (address _logicalContract)  external;
    
    function setLogicalContract (address _logicalContract, uint256 _logicalContractIndex)  external;
    
    function getLogicalContract (uint256 _logicalContractIndex) external view returns(address);
    
    function getLogicalContractLength () external view returns(uint256);
    
    function withdrawFee (address payable _destination, uint256 _amount)  external;
    

    
    
    function addGame (uint256 _logicalContractIndex, uint32  _gameType,  address payable _creator, uint256 _residualJackpot,  uint256[3] calldata _gameLimits, uint256[2] calldata _timeouts, uint256[2] calldata _times, uint256 _quote, bytes32 _solutionHash, string calldata _solution) external;
      
    function setGameType (uint256 _logicalContractIndex, uint256 _gameIndex, uint32 _gameType) external;
     
    function setGameCreator (uint256 _logicalContractIndex, uint256 _gameIndex, address payable _creator)  external ;
  
    function setGameResidualJackpot (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _residualJackpot)  external ;
    
    function setGameMaxOffer (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _maxOffer)  external;
    
    function setGameMinOffer (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _minOffer)  external;
    
    function setGameMaxOfferNumber (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _maxOfferNumber)  external;
    
    function setTimePropose (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timePropose)  external;
    
    function setGametimeoutOffer(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timeoutOffer)  external;
    
    function setGameTimeCreationGame(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timeCreationGame)  external;
    
    function setGameTimeoutResolution(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timeoutResolution)  external;
    
    function setGameQuote(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _quote)  external;
    
    function setGameSolutionHash(uint256 _logicalContractIndex, uint256 _gameIndex, bytes32 _solutionHash)  external;
    
    function setGameSolution(uint256 _logicalContractIndex, uint256 _gameIndex, string calldata _solution)  external;
    
    function getGameType (uint256 _gameIndex) external view returns(uint32);
    
    function getGameCreator (uint256 _gameIndex) external view returns(address payable);
    
    function getGameResidualJackpot (uint256 _gameIndex) external view returns(uint256);
    
    function getGameMaxOffer(uint256 _gameIndex) external view returns(uint256);
    
    function getGameMinOffer (uint256 _gameIndex) external view returns(uint256);
    
    function getGameMaxOfferNumber (uint256 _gameIndex) external view returns(uint256);
    
    function getGameTimePropose (uint256 _gameIndex) external view returns(uint256);
    
    function getGameTimeoutOffer (uint256 _gameIndex) external view returns(uint256);
    
    function getGameTimeCreationGame(uint256 _gameIndex) external view returns(uint256);
    
    function getGameTimeoutResolution (uint256 _gameIndex) external view returns(uint256);
    
    function getGameQuote (uint256 _gameIndex) external view returns(uint256);
    
    function getGameSolutionHash (uint256 _gameIndex) external view returns(bytes32);
    
    function getGameSolution (uint256 _gameIndex) external view returns(string memory);
    
    function getGamesLength ()  external view returns(uint256);
    

   
    
    
    function setGameMetadata (uint256 _logicalContractIndex, uint256 _gameIndex, string calldata _gameMetadata)  external;
    
    function getGameMetadata(uint256 _gameIndex) external view returns(string memory);
   
    
    

    
    
    function addOffer (uint256 _logicalContractIndex, uint256 _gameIndex, address payable _player, uint256 _expectedwin, uint256 _serviceFee, bytes32 _solutionHash, string calldata _solutionPlayer, uint256 _lastInteraction, uint256 _solutionResult, uint256[6] calldata _disputeFields)  external;
    
    function setOfferPlayer (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, address payable _player) external;
    
    function setOfferExpectedWin (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _expectedWin) external;
    
    function setOfferServiceFee (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _serviceFee)  external;
    
    function setOfferSolutionHash (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, bytes32 _solutionHash) external;
    
    function setOfferSolutionPlayer(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, string calldata _solutionPlayer)   external;
    
    function setOfferLastInteraction(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _lastInteraction) external;
    
    function setOfferSolutionResult(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _solutionResult)   external;
    
    function setOfferDisputeId(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _disputeId)   external;
	
    function setOfferTimeDispute(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _timeDispute)  external;
    
    function setOfferPlayerFee(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _playerFee)   external;
    
    function setOfferCreatorFee(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _creatorFee)   external;
    
    function setOfferAppeal(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _appeal)   external;
    
    function setOfferAppealFee(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _appealFee)   external;
    
    function getOfferPlayer (uint256 _gameIndex, uint256 _offerIndex) external view returns(address payable);
    
    function getOfferExpectedWin (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferServiceFee (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferSolutionHash (uint256 _gameIndex, uint256 _offerIndex) external view returns(bytes32);
    
    function getOfferSolutionPlayer (uint256 _gameIndex, uint256 _offerIndex) external view returns(string memory);
    
    function getOfferLastInteraction (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferSolutionResult (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferDisputeId (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
	
    function getOfferTimeDispute (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferPlayerFee (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferCreatorFee (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferAppeal (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
    
    function getOfferAppealFee(uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256);
      
    function getOffersLength (uint256 _gameIndex)  external view returns(uint256);
    
    

    
    
    function addOffersMap (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, uint256 _indexOffer, bool _submittedOffer, bool _submittedHashSol, bool _submittedSol)  external;
    
    function setOffersMapIndexOffer (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, uint256 _indexOffer)  external;
    
    function setOffersMapSubmittedOffer (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, bool _submittedOffer)  external;
	
    function setOffersMapSubmittedHashSol (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, bool _submittedHashSol)  external;
	
    function setOffersMapSubmittedSol (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, bool _submittedSol)  external;
    
    function getOffersMapIndexOffer (uint256 _gameIndex, address _player) external view returns (uint256);
    
    function getOffersMapSubmittedOffer(uint256 _gameIndex, address _player) external view returns (bool);
    
    function getOffersMapSubmittedHashSol (uint256 _gameIndex, address _player) external view returns (bool);
    
    function getOffersMapSubmittedSol (uint256 _gameIndex, address _player) external view returns (bool);
    

    
 
 
    function addCreationMap (uint256 _logicalContractIndex, uint256 _gameIndex, bool _submittedGame, bool _submittedSol)  external;
    
    function setCreationMapSubmittedGame (uint256 _logicalContractIndex, uint256 _gameIndex, bool _submittedGame)  external;
    
    function setCreationMapSubmittedSol (uint256 _logicalContractIndex, uint256 _gameIndex, bool _submittedSol)  external;
    
    function getCreationMapSubmittedGame (uint256 _gameIndex) external view returns(bool);
    
    function getCreationMapSubmittedSol (uint256 _gameIndex) external view returns(bool);
    

    
    
    function addDisputeIDtoArbitrationIndexID (uint256 _logicalContractIndex, uint256 _disputeId,  uint256 _gameIndex, address payable _player)  external;
    
    function setDisputeIDtoArbitrationIndexIDGameIndex (uint256 _logicalContractIndex, uint256 _disputeId,  uint256 _gameIndex)  external;
    
    function setDisputeIDtoArbitrationIndexIDPlayer (uint256 _logicalContractIndex, uint256 _disputeId,  address payable _player)  external;
    
    function getDisputeIDtoArbitrationIndexIDGameIndex (uint256 _disputeId) external view returns(uint256);
    
    function getDisputeIDtoArbitrationIndexIDPlayer (uint256 _disputeId) external view returns(address payable);
    

    
    function SetFeeBalance (uint256 _logicalContractIndex, uint256 _feeBalance)  external;
    
    function getFeeBalance() external view returns(uint256);
    
    function transferEth (uint256 _logicalContractIndex, address payable _destination, uint256 _amount)  external;
    
    function () external payable {}

}

contract LogicalPuzzlesWithdrawAbstract  {
    function emitSolutionStatusLog ( uint256 _logicalContractIndex, uint256  _gameId, address  _player,  bool _WonOrLost, uint256 _amount)  external;
}
   

contract LogicalPuzzlesDisputeWithdraw  {
    using SafeMath for uint256;
    
    enum Result {NOTHING, WAITING_CREATOR, WAITING_PLAYER, DISPUTE_CREATED, PLAYER_WINS, CREATOR_WINS, NO_WINNER}
    
    enum Appeal {NO_APPEAL, PLAYER_APPEAL, CREATOR_APPEAL}
    
    uint8 constant AMOUNT_OF_CHOICES = 2;
    uint8 constant PLAYER_WINS = 1;
    uint8 constant CREATOR_WINS = 2;

 
    
    StoragePuzzlesAbstract public storagepuzzles;
    
    modifier onlyOtherLogicalContracts(uint256 _logicalContractIndex) {
        require (_logicalContractIndex<storagepuzzles.getLogicalContractLength(), "Logical contract index not present");
        require (storagepuzzles.getLogicalContract(_logicalContractIndex)==msg.sender, "Sender different from logical contract");
        _;
    }
    
    constructor (address payable _storagepuzzles) public {
        storagepuzzles=StoragePuzzlesAbstract(_storagepuzzles);
    }
    
    function timeOutByPlayer(uint256 _gameIndex) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "game not created");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        require(storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) == uint256(Result.WAITING_CREATOR), "The transaction is not waiting on the creator.");
        require(now-storagepuzzles.getOfferLastInteraction(_gameIndex,indexoffer) > storagepuzzles.getFeeTimeout(), "Timeout time has not passed yet.");
        executeRuling(_gameIndex, msg.sender, uint256(PLAYER_WINS));
    }
     
     
    function timeOutByCreator(uint256 _gameIndex, address payable _player) external {
        require (_gameIndex<storagepuzzles.getGamesLength());
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution game not submitted");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true, "solution player not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player );
        require(storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) == uint256(Result.WAITING_PLAYER), "The transaction is not waiting on the player.");
        require(now-storagepuzzles.getOfferLastInteraction(_gameIndex,indexoffer) > storagepuzzles.getFeeTimeout(), "Timeout time has not passed yet.");
        executeRuling(_gameIndex, _player, uint256(CREATOR_WINS));
    }
     
    function executeRulingExternal(uint256 _logicalContractIndex,uint256 _gameIndex , address payable _player, uint256 _ruling) onlyOtherLogicalContracts(_logicalContractIndex) external {
        executeRuling(_gameIndex ,_player,_ruling);
    } 
    
   
    function executeRuling(uint256 _gameIndex , address payable _player, uint256 _ruling) internal {
        require(_ruling <= AMOUNT_OF_CHOICES, "Invalid ruling.");
        // Give the arbitration fee back.
        // Note that we use send to prevent a party from blocking the execution.
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        uint256[] memory values=new uint256[](8);
        values[0]=storagepuzzles.getOfferExpectedWin(_gameIndex,indexoffer); //grosswin
        values[1]=values[0]-(storagepuzzles.getOfferServiceFee(_gameIndex,indexoffer));//netwin
        values[2]=values[0]-values[1]; //fee
        values[3]=(values[0].mul(100))/storagepuzzles.getGameQuote(_gameIndex);//valuebet
        if (storagepuzzles.getOfferAppeal(_gameIndex,indexoffer)==uint256(Appeal.PLAYER_APPEAL)) {
            values[4]=storagepuzzles.getOfferAppealFee(_gameIndex,indexoffer); //fee appeal player
        }
        if (storagepuzzles.getOfferAppeal(_gameIndex,indexoffer)==uint256(Appeal.CREATOR_APPEAL)) {
            values[5]=storagepuzzles.getOfferAppealFee(_gameIndex,indexoffer); //fee appeal creator
        }
        values[6]=storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer);//fee arbitration player
        values[7]=storagepuzzles.getOfferCreatorFee(_gameIndex,indexoffer);//fee arbitration creator
        LogicalPuzzlesWithdrawAbstract logicalpuzzleswithdraw= LogicalPuzzlesWithdrawAbstract(storagepuzzles.getLogicalContract(1));
        address payable creator=storagepuzzles.getGameCreator(_gameIndex);
        storagepuzzles.SetFeeBalance(4,storagepuzzles.getFeeBalance().add(values[2]));
        if (_ruling == PLAYER_WINS) {
            storagepuzzles.transferEth(4,_player,values[1]+values[6]);
            if (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) == uint256(Result.WAITING_CREATOR)) {
                storagepuzzles.transferEth(4,creator,values[7]);
                logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, creator, false , values[0]-values[3]);
            }
            else {
                logicalpuzzleswithdraw.emitSolutionStatusLog(4,_gameIndex, storagepuzzles.getGameCreator(_gameIndex), false , values[0]-values[3]+values[7]+values[5]);
            }
            if (values[1].sub(values[3]) > values[4])  {  
                logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, _player, true , values[1]-values[3]-values[4]);
            }
            else {
                logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, _player, false , values[4]-values[1]+values[3]);
            }
            storagepuzzles.setOfferSolutionResult(4,_gameIndex,indexoffer,uint256(Result.PLAYER_WINS));
        } 
        else if (_ruling == CREATOR_WINS) {   
            storagepuzzles.transferEth(4,creator,values[1]+values[7]);
            if (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) == uint256(Result.WAITING_PLAYER)) {
                storagepuzzles.transferEth(4,_player,values[6]);
                logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, _player , false , values[3]); 
            } else {
                logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, _player , false , values[3]+values[6]+values[4]);
            }
            if (values[3].sub(values[2]) > values[5])  {
                logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, storagepuzzles.getGameCreator(_gameIndex), true , values[3]-values[2]-values[5]);
            } else {
                logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, storagepuzzles.getGameCreator(_gameIndex) , false , values[5]-values[3]+values[2]);
            }
            storagepuzzles.setOfferSolutionResult(4,_gameIndex,indexoffer,uint256(Result.CREATOR_WINS));
        }
        else {
            uint256 playeramount = values[3]+(values[6]/2).sub(values[2]/2);
            uint256 creatoramount = values[0]-values[3]+(values[7]/2).sub(values[2]/2);
            storagepuzzles.transferEth(4,_player,playeramount);
            storagepuzzles.transferEth(4,creator,creatoramount);
            logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex,creator , false , (values[7]/2)+(values[2]/2)+values[5]);
            logicalpuzzleswithdraw.emitSolutionStatusLog (4,_gameIndex, _player , false , (values[6]/2)+(values[2]/2)+values[4]);
            storagepuzzles.setOfferSolutionResult(4,_gameIndex,indexoffer,uint256(Result.NO_WINNER));
        }
        
    }
    
    function WithdrawPlayerNoRuling(uint256 _gameIndex) external  {
        require (_gameIndex<storagepuzzles.getGamesLength());
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution game not created");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "solution player not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        require(storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)== uint256(Result.DISPUTE_CREATED), "The dispute has already been resolved.");
        require(now > storagepuzzles.getOfferTimeDispute(_gameIndex,indexoffer).add(storagepuzzles.getTimeoutRuling()), "Ruling yet activated");
        executeRuling(_gameIndex, msg.sender, 0);
    }
    
    function WithdrawCreatorNoRuling(uint256 _gameIndex) external  {
        require (_gameIndex<storagepuzzles.getGamesLength());
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution game not created");
        for (uint256 j=0; j<storagepuzzles.getOffersLength(_gameIndex); j++) {
            if (storagepuzzles.getOfferSolutionResult(_gameIndex,j)== uint256(Result.DISPUTE_CREATED) && now > storagepuzzles.getOfferTimeDispute(_gameIndex,j).add(storagepuzzles.getTimeoutRuling())) {
                executeRuling(_gameIndex, storagepuzzles.getOfferPlayer(_gameIndex,j), 0);
            }
        } 
    }
    
    function WithdrawCreatorNoRulingSingle (uint256 _gameIndex, address payable _player) external {
        require (_gameIndex<storagepuzzles.getGamesLength());
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution game not created");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true, "solution player not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        require(storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)== uint256(Result.DISPUTE_CREATED), "The dispute has already been resolved.");
        require(now > storagepuzzles.getOfferTimeDispute(_gameIndex,indexoffer).add(storagepuzzles.getTimeoutRuling()), "Ruling yet activated");
        executeRuling(_gameIndex,_player, 0);
    }
}
    