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

contract LogicalPuzzlesArbitrableAbstract {
    function emitMetaEvidence(uint256 _logicalContractIndex,uint256 _gameIndex, string calldata  _gameCreationMetadata) external;
}


contract LogicalPuzzlesCreation  {
    using SafeMath for uint256;
    
    enum Result {NOTHING, WAITING_CREATOR, WAITING_PLAYER, DISPUTE_CREATED, PLAYER_WINS, CREATOR_WINS, NO_WINNER}
    
    enum Appeal {NO_APPEAL, PLAYER_APPEAL, CREATOR_APPEAL}
    
    
    event GamesSource (uint256 indexed _gameId,  address indexed _creator, uint32 indexed _puzzleType, string _puzzleName, string _metadata)  ;
    
    event GamesValues (uint256 indexed _gameId,  uint256 _maxJackpot, uint256 _quote, uint256 _maxOffer, uint256 _minOffer, uint256 _maxNumberOffer,  uint256 _timePropose, uint256 _timeoutOffer, uint256 _timeoutPlayerSolution)  ;
    
    event GameCreation (uint256 indexed _gameId, uint256 _timeCreation, string _metadataCreation);
        
    event OffersLog (uint256 indexed _gameId, address indexed _player, uint256 _valueBet, uint256 _expectedWin, uint256 _fee);
    
    event ResidualLog (uint256 indexed _gameId, uint256 _residual);
    
    event SolutionPlayerLog(uint256 indexed _gameId, address indexed _player, string _solution);
    
    event SolutionCreatorLog (uint256 indexed _gameId, address indexed _creator,  string _solution);
    
    
    StoragePuzzlesAbstract public storagepuzzles;
    
    /*modifier onlyOtherLogicalContracts(uint256 _logicalContractIndex) {
        require (_logicalContractIndex<storagepuzzles.getLogicalContractLength(), "Logical contract index not present");
        require (storagepuzzles.getLogicalContract(_logicalContractIndex)==msg.sender, "Sender different from logical contract");
        _;
    }*/
    
    constructor (address payable _storagepuzzles) public {
        storagepuzzles=StoragePuzzlesAbstract(_storagepuzzles);
    }
    
    function proposeGame (string calldata _gameName, string calldata _gameProposeMetadata, uint32  _gameType, uint256[3] calldata _gameLimits, uint256[2] calldata _timeouts, uint256 _quote, bytes32 _solutionHash)  external payable {
        require (_gameType<storagepuzzles.GetGameTypeLength() && storagepuzzles.GetGameType(_gameType)==true, "game type does not exist or not valid");
       // require (msg.value >=storagepuzzles.getMinimalJackpot() && (msg.value/10000000)*(10000000)==msg.value, "value sent not correct");
        require (msg.value >=storagepuzzles.getMinimalJackpot() && msg.value%10000000==0, "value sent not correct");
        require (_quote > 100 && _quote.mul(100000)<=msg.value+10000000, "quote not correct" );
        require (_quote.mul(10000-storagepuzzles.getFeePercent()) > 1000000 && _quote.mul(storagepuzzles.getFeePercent()) < 1000000, "quote non permitted according to fee" );//condition that net_win - value_bet >0 (fee doesn't overcome value initially bet)
        //require ((_gameLimits[0]/10000000)*(10000000)==_gameLimits[0]  && (_gameLimits[0].mul(_quote))/100<=msg.value.add(_gameLimits[0]), "maximal offer not permitted");
        require (_gameLimits[0]%10000000==0  && (_gameLimits[0].mul(_quote))/100<=msg.value.add(_gameLimits[0]), "maximal offer not permitted");
        //require ((_gameLimits[1]/10000000)*(10000000)==_gameLimits[1]  && _gameLimits[1]<_gameLimits[0], "minimal offer not permitted");
        require (_gameLimits[1]%10000000==0   && _gameLimits[1]<_gameLimits[0], "minimal offer not permitted");
        require (_gameLimits[2]!=0, "max number offer null");
        require (_timeouts[0]!=0 && _timeouts[1]!=0, "Timeout can't be null");
        uint256[2] memory _times=[now,0];
        storagepuzzles.addGame(0,_gameType, msg.sender, msg.value, _gameLimits, _timeouts, _times, _quote, _solutionHash, "");
        uint256 gameindex=storagepuzzles.getGamesLength()-1;
        emit GamesSource (gameindex, msg.sender, _gameType , _gameName, _gameProposeMetadata);
        emit GamesValues (gameindex , msg.value,  _quote, _gameLimits[0], _gameLimits[1], _gameLimits[2], now,  _timeouts[0] , _timeouts[1]);
        emit ResidualLog (gameindex, msg.value);
        LogicalPuzzlesArbitrableAbstract logicalpuzzlesarbitrable= LogicalPuzzlesArbitrableAbstract(storagepuzzles.getLogicalContract(2));
        logicalpuzzlesarbitrable.emitMetaEvidence(0,gameindex, _gameProposeMetadata);
        address(storagepuzzles).transfer(msg.value);
    }
    
    
    function createOffer (uint256 _gameIndex)  external payable {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getGameCreator(_gameIndex)!=msg.sender, "sender must not be game creator");
        require (!storagepuzzles.getOffersMapSubmittedOffer(_gameIndex, msg.sender)==true, "Offer already submitted");
       // require (msg.value<=storagepuzzles.getGameMaxOffer(_gameIndex)&& msg.value>=storagepuzzles.getGameMinOffer(_gameIndex) && (msg.value/10000000)*10000000==msg.value,"Value sent not permitted");
        require (msg.value<=storagepuzzles.getGameMaxOffer(_gameIndex)&& msg.value>=storagepuzzles.getGameMinOffer(_gameIndex) && msg.value%10000000==0,"Value sent not permitted");
        uint256 quote=storagepuzzles.getGameQuote(_gameIndex);
        require (quote.mul(10000-storagepuzzles.getFeePercent()) > 1000000 && quote.mul(storagepuzzles.getFeePercent()) < 1000000, "quote non permitted according to fee" ); //test needed in case getfeepercent changed from propose game time
        uint256 expectedwin=(msg.value.mul(quote))/100 ;
        require (expectedwin <= storagepuzzles.getGameResidualJackpot(_gameIndex)+msg.value, "Not enough residual jackpot for this offer");
        require (now > storagepuzzles.getGameTimePropose(_gameIndex) && now <= storagepuzzles.getGameTimePropose(_gameIndex).add(storagepuzzles.getGameTimeoutOffer(_gameIndex)),"Timeout for offer already activated");
        require (storagepuzzles.getOffersLength(_gameIndex)<storagepuzzles.getGameMaxOfferNumber(_gameIndex), "Max number of offers already reached");
        uint256[6] memory _disputeFields=[0,0,0,0,uint256(Appeal.NO_APPEAL),0];
        uint256 servicefee=expectedwin.mul(storagepuzzles.getFeePercent())/10000;
        storagepuzzles.addOffer (0, _gameIndex,msg.sender,expectedwin,servicefee,"0x","",now, uint256(Result.NOTHING),_disputeFields);
        storagepuzzles.addOffersMap (0, _gameIndex, msg.sender , storagepuzzles.getOffersLength(_gameIndex)-1 ,true,false,false);
        storagepuzzles.setGameResidualJackpot (0, _gameIndex, storagepuzzles.getGameResidualJackpot(_gameIndex)-(expectedwin-msg.value)); 
        emit OffersLog (_gameIndex, msg.sender, msg.value, expectedwin,servicefee);
        emit ResidualLog (_gameIndex,  storagepuzzles.getGameResidualJackpot(_gameIndex) );
        address(storagepuzzles).transfer(msg.value);
    }
    
   
    
    function createGame (uint256 _gameIndex, string calldata _gameMetadata) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender, "sender must be game creator");
        require (!storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has already been created");
        require(now > storagepuzzles.getGameTimePropose(_gameIndex).add(storagepuzzles.getGameTimeoutOffer(_gameIndex)) && now <= storagepuzzles.getGameTimePropose(_gameIndex).add(storagepuzzles.getGameTimeoutOffer(_gameIndex)).add(storagepuzzles.getMaxTimeoutCreation()), "Timeout for game creation already activated");
        storagepuzzles.setGameTimeCreationGame(0, _gameIndex, now);
        storagepuzzles.addCreationMap (0, _gameIndex, true, false);
        emit GameCreation (_gameIndex,now, _gameMetadata);
        storagepuzzles.setGameMetadata (0,_gameIndex, _gameMetadata);
    }
    
    
    
    function submitSolutionHash (uint256 _gameIndex, bytes32 _solutionHash ) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has not been created");
        require (storagepuzzles.getOffersMapSubmittedOffer(_gameIndex,msg.sender)==true, "offer not submitted" );
        require (!storagepuzzles.getOffersMapSubmittedHashSol(_gameIndex,msg.sender)==true, "solution hash already submitted");
        require (now > storagepuzzles.getGameTimeCreationGame(_gameIndex) && now <= storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)), "timeout for hash solution sumbission already activated");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        storagepuzzles.setOfferSolutionHash(0,_gameIndex,indexoffer,_solutionHash);
        storagepuzzles.setOffersMapSubmittedHashSol(0,_gameIndex,msg.sender,true);
    }
    
    function submitSolutionPlayer (uint256 _gameIndex, string calldata _solutionPlayer, bytes32 _secret)  external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has not been created");
        require (storagepuzzles.getOffersMapSubmittedHashSol(_gameIndex,msg.sender)==true, "solution hash not submitted");
        require (!storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "solution already submitted");
        require (now >storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)) && now <= storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()), "timeout for  solution sumbission already activated");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        bytes32 solutionhash=storagepuzzles.getOfferSolutionHash(_gameIndex,indexoffer);
        require (bytes(_solutionPlayer).length!=0, "string player solution void");
        require (keccak256(abi.encodePacked(_secret,_solutionPlayer))==solutionhash, "solution not compatible with hash");
        storagepuzzles.setOfferSolutionPlayer(0,_gameIndex,indexoffer,_solutionPlayer);
        storagepuzzles.setOffersMapSubmittedSol(0,_gameIndex, msg.sender,true);
        emit SolutionPlayerLog(_gameIndex, msg.sender, _solutionPlayer);
    }
   
    function submitSolutionCreator (uint256 _gameIndex, string calldata _solutionGame, bytes32 _secret)  external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game has not been created");
        require (!storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution already submitted");
        require (now > storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()) && now<=storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()), "timeout for  solution  already activated");
        require (bytes(_solutionGame).length!=0, "string game solution void");
        require (keccak256(abi.encodePacked(_secret,_solutionGame))==storagepuzzles.getGameSolutionHash(_gameIndex), "solution not compatible with hash");
        storagepuzzles.setGameSolution(0,_gameIndex,_solutionGame);
        storagepuzzles.setCreationMapSubmittedSol(0,_gameIndex,true);
        emit SolutionCreatorLog (_gameIndex, msg.sender, _solutionGame);
    }
   
    function withdrawResidual (uint256 _gameIndex) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender, "sender must be game creator");
        require (now > storagepuzzles.getGameTimePropose(_gameIndex).add(storagepuzzles.getGameTimeoutOffer(_gameIndex)), "Offer period open yet");
        storagepuzzles.transferEth(0,msg.sender,storagepuzzles.getGameResidualJackpot(_gameIndex));
        storagepuzzles.setGameResidualJackpot (0, _gameIndex, 0); 
        emit ResidualLog (_gameIndex, 0);
    }
    
}