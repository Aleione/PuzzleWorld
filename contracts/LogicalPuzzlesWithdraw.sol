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
        require(b <= a);
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
   
   
contract LogicalPuzzlesWithdraw {
   
    using SafeMath for uint256;
    
    enum Result {NOTHING, WAITING_CREATOR, WAITING_PLAYER, DISPUTE_CREATED, PLAYER_WINS, CREATOR_WINS, NO_WINNER}
    
    event SolutionStatusLog (uint256 indexed _gameId, address indexed _player,  bool _WonOrLost, uint256 _amount);
 
    StoragePuzzlesAbstract public storagepuzzles;
   
    modifier onlyOtherLogicalContracts(uint256 _logicalContractIndex) {
        require (_logicalContractIndex<storagepuzzles.getLogicalContractLength(), "Logical contract index not present");
        require (storagepuzzles.getLogicalContract(_logicalContractIndex)==msg.sender, "Sender different from logical contract");
        _;
    }
    
    constructor (address payable _storagepuzzles) public {
        storagepuzzles=StoragePuzzlesAbstract(_storagepuzzles);
    }
 
  
 
    
    function withdrawNonSubmittedGame (uint256 _gameIndex) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (!storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has been created");
        require (storagepuzzles.getOffersMapSubmittedOffer(_gameIndex,msg.sender)==true, "offer not submitted" );
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)==uint256(Result.NOTHING), "Solution result not in default state");
        require (now > storagepuzzles.getGameTimePropose(_gameIndex).add(storagepuzzles.getGameTimeoutOffer(_gameIndex)).add(storagepuzzles.getMaxTimeoutCreation()) , "game creation yet possible");
        uint256 grosswin=storagepuzzles.getOfferExpectedWin(_gameIndex, indexoffer);
        uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex, indexoffer);
        uint256 netwin= grosswin-fee;
        uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
        emit SolutionStatusLog (_gameIndex, msg.sender, true, netwin.sub(valuebet));
        emit SolutionStatusLog (_gameIndex, storagepuzzles.getGameCreator(_gameIndex), false , grosswin-valuebet);
        storagepuzzles.setOfferSolutionResult(1, _gameIndex, indexoffer, uint256(Result.PLAYER_WINS));
        storagepuzzles.SetFeeBalance(1,storagepuzzles.getFeeBalance().add(fee));
        storagepuzzles.transferEth(1,msg.sender,netwin);
    }
    
    
    function playerWithdraw (uint256 _gameIndex)  external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has not been created");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        require(storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)==uint256(Result.NOTHING), "Solution result not in default state");
        require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()), "withdraw win not already activated");
        if (now<=storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()).add(storagepuzzles.getTimeoutDisp()))  {
            require(!storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution submitted");
        } else {
            string memory gamesolution=storagepuzzles.getGameSolution(_gameIndex);
            string memory playersolution=storagepuzzles.getOfferSolutionPlayer(_gameIndex,indexoffer);
            require (!storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true || keccak256(abi.encodePacked(gamesolution)) ==  keccak256(abi.encodePacked(playersolution)), "solution submitted and solution player wrong " );
        }
        uint256 grosswin=storagepuzzles.getOfferExpectedWin(_gameIndex,indexoffer);
        uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex, indexoffer);
        uint256 netwin= grosswin-fee;
        uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
        emit SolutionStatusLog (_gameIndex, msg.sender, true , netwin.sub(valuebet));
        emit SolutionStatusLog (_gameIndex, storagepuzzles.getGameCreator(_gameIndex) , false , grosswin-valuebet);
        storagepuzzles.setOfferSolutionResult(1,_gameIndex,indexoffer,uint256(Result.PLAYER_WINS));
        storagepuzzles.SetFeeBalance(1,storagepuzzles.getFeeBalance().add(fee));
        storagepuzzles.transferEth(1,msg.sender,netwin);
    }
   
    
    function creatorWithdraw (uint256 _gameIndex) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution not submitted");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()).add(storagepuzzles.getTimeoutDisp()),"timeout for withdraw win already activated");
        uint256 totalFee=0;
        uint256 totalNetWin=0;
        for (uint256 j=0; j<storagepuzzles.getOffersLength(_gameIndex); j++)  {
            address player=storagepuzzles.getOfferPlayer(_gameIndex,j);
            if (storagepuzzles.getOfferSolutionResult(_gameIndex, j)==uint256(Result.NOTHING) && (!storagepuzzles.getOffersMapSubmittedSol(_gameIndex,player)==true || keccak256(abi.encodePacked(storagepuzzles.getGameSolution(_gameIndex))) !=  keccak256(abi.encodePacked(storagepuzzles.getOfferSolutionPlayer(_gameIndex,j))) ) ) {
                uint256 grosswin = storagepuzzles.getOfferExpectedWin(_gameIndex, j);
                uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex, j);
                uint256 netwin = grosswin-fee;
                uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
                emit SolutionStatusLog (_gameIndex, storagepuzzles.getOfferPlayer(_gameIndex, j) , false , valuebet);  
                emit SolutionStatusLog (_gameIndex, storagepuzzles.getGameCreator(_gameIndex) , true , valuebet.sub(fee)); 
                storagepuzzles.setOfferSolutionResult(1, _gameIndex, j, uint256(Result.CREATOR_WINS));
                totalFee=totalFee+fee;
                totalNetWin=totalNetWin+netwin;
            } 
        }
        storagepuzzles.SetFeeBalance(1,storagepuzzles.getFeeBalance().add(totalFee));
        storagepuzzles.transferEth(1,msg.sender,totalNetWin);
    }
	
	
    
    function creatorWithdrawSingle (uint256 _gameIndex, address _player) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution not submitted");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getOffersMapSubmittedOffer(_gameIndex, _player)==true, "offer not submitted" );
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex, indexoffer)==uint256(Result.NOTHING),"Solution result not in default state");
        require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()),"timeout for withdraw win already activated");
        if (now<=storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()).add(storagepuzzles.getTimeoutDisp()))  {
            require(!storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true, "solution player submitted");
        } else {
            string memory gamesolution=storagepuzzles.getGameSolution(_gameIndex);
            string memory playersolution=storagepuzzles.getOfferSolutionPlayer(_gameIndex,indexoffer);
            require (!storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true || keccak256(abi.encodePacked(gamesolution)) !=  keccak256(abi.encodePacked(playersolution)), "Player solution submitted and correct" );
        }
        uint256 grosswin = storagepuzzles.getOfferExpectedWin(_gameIndex, indexoffer);
        uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex, indexoffer);
        uint256 netwin = grosswin-fee;
        uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
        emit SolutionStatusLog (_gameIndex, storagepuzzles.getOfferPlayer(_gameIndex, indexoffer) , false , valuebet);  
        emit SolutionStatusLog (_gameIndex, msg.sender, true , valuebet.sub(fee)); 
        storagepuzzles.setOfferSolutionResult(1, _gameIndex, indexoffer, uint256(Result.CREATOR_WINS));
        storagepuzzles.SetFeeBalance(1,storagepuzzles.getFeeBalance().add(fee));
        storagepuzzles.transferEth(1,msg.sender,netwin);
    }
    
    function bothNoSolutionPlayerWithdraw (uint256 _gameIndex) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has not been created");
        require (!storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution not submitted");
        require (storagepuzzles.getOffersMapSubmittedOffer(_gameIndex,msg.sender)==true, "offer not submitted" );
        require (!storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "solution submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex, indexoffer)==uint256(Result.NOTHING),"Solution result not in default state");
        require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()),"withdraw win not already activated");
        uint256 grosswin = storagepuzzles.getOfferExpectedWin(_gameIndex, indexoffer);
        uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex, indexoffer);
        uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
        uint256 playeramount = valuebet.sub(fee/2);
        uint256 creatoramount = (grosswin-valuebet).sub(fee/2);
        emit SolutionStatusLog (_gameIndex, storagepuzzles.getGameCreator(_gameIndex) , false , fee/2);
        emit SolutionStatusLog (_gameIndex, msg.sender , false , fee/2);
        storagepuzzles.setOfferSolutionResult(1, _gameIndex, indexoffer, uint256(Result.NO_WINNER));
        storagepuzzles.SetFeeBalance(1,storagepuzzles.getFeeBalance().add(fee));
        storagepuzzles.transferEth(1,msg.sender,playeramount);
        storagepuzzles.transferEth(1,storagepuzzles.getGameCreator(_gameIndex),creatoramount);
    }
    
    function bothNoSolutionCreatorWithdraw (uint256 _gameIndex ) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has not been created");
        require (!storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution not submitted");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()),"withdraw win not already activated");
        uint256 totalFee=0;
        uint256 totalCreatorAmount=0;
        for (uint256 j=0; j<storagepuzzles.getOffersLength(_gameIndex); j++) {
            address payable player=storagepuzzles.getOfferPlayer(_gameIndex, j);
            if(storagepuzzles.getOffersMapSubmittedOffer(_gameIndex,player)==true && !storagepuzzles.getOffersMapSubmittedSol(_gameIndex,player)==true && storagepuzzles.getOfferSolutionResult(_gameIndex, j)==uint256(Result.NOTHING)) {
                uint256 grosswin = storagepuzzles.getOfferExpectedWin(_gameIndex, j);
                uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex,j);
                uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
                uint256 playeramount = valuebet.sub(fee/2);
                uint256 creatoramount = (grosswin-valuebet).sub(fee/2);
                emit SolutionStatusLog (_gameIndex, msg.sender , false , fee/2);
                emit SolutionStatusLog (_gameIndex, player , false , fee/2);
                storagepuzzles.setOfferSolutionResult(1, _gameIndex, j, uint256(Result.NO_WINNER));
                storagepuzzles.transferEth(1, player, playeramount);
                totalFee=totalFee+fee;
                totalCreatorAmount=totalCreatorAmount+creatoramount;
            }
        }
        storagepuzzles.SetFeeBalance(1,storagepuzzles.getFeeBalance().add(totalFee));
        storagepuzzles.transferEth(1,msg.sender,totalCreatorAmount);
    }
        
       
    function bothNoSolutionCreatorWithdrawSingle (uint256 _gameIndex, address payable _player) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has not been created");
        require (!storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution not submitted");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getOffersMapSubmittedOffer(_gameIndex,_player)==true, "offer not submitted" );
        require (!storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true, "solution submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex, indexoffer)==uint256(Result.NOTHING),"Solution result not in default state");
        require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()),"withdraw win not already activated");
        uint256 grosswin = storagepuzzles.getOfferExpectedWin(_gameIndex, indexoffer);
        uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex, indexoffer);
        uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
        uint256 playeramount = valuebet.sub(fee/2);
        uint256 creatoramount = (grosswin-valuebet).sub(fee/2);
        emit SolutionStatusLog (_gameIndex, msg.sender , false , fee/2);
        emit SolutionStatusLog (_gameIndex, _player , false , fee/2);
        storagepuzzles.setOfferSolutionResult(1, _gameIndex, indexoffer, uint256(Result.NO_WINNER));
        storagepuzzles.SetFeeBalance(1,storagepuzzles.getFeeBalance().add(fee));
        storagepuzzles.transferEth(1,msg.sender,creatoramount);
        storagepuzzles.transferEth(1,_player, playeramount);
    }
    
    
    
    function emitSolutionStatusLog (uint256 _logicalContractIndex,uint256  _gameId, address  _player,  bool _WonOrLost, uint256 _amount)   onlyOtherLogicalContracts(_logicalContractIndex) external {
        emit SolutionStatusLog (_gameId, _player, _WonOrLost, _amount);
    } 
    
}