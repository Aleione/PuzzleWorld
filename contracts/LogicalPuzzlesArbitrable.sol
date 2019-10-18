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

contract LogicalPuzzlesDisputeWithdrawAbstract  {
    function executeRulingExternal(uint256 _logicalContractIndex, uint256 _gameIndex , address payable _player, uint256 _ruling) external;
}
   
interface IArbitrable {
    /** @dev To be emmited when meta-evidence is submitted.
     *  @param _metaEvidenceID Unique identifier of meta-evidence.
     *  @param _evidence A link to the meta-evidence JSON.
     */
    event MetaEvidence(uint indexed _metaEvidenceID, string _evidence);

    /** @dev To be emmited when a dispute is created to link the correct meta-evidence to the disputeID
     *  @param _arbitrator The arbitrator of the contract.
     *  @param _disputeID ID of the dispute in the Arbitrator contract.
     *  @param _metaEvidenceID Unique identifier of meta-evidence.
     *  @param _evidenceGroupID Unique identifier of the evidence group that is linked to this dispute.
     */
    event Dispute(Arbitrator indexed _arbitrator, uint indexed _disputeID, uint _metaEvidenceID, uint _evidenceGroupID);

    /** @dev To be raised when evidence are submitted. Should point to the ressource (evidences are not to be stored on chain due to gas considerations).
     *  @param _arbitrator The arbitrator of the contract.
     *  @param _evidenceGroupID Unique identifier of the evidence group the evidence belongs to.
     *  @param _party The address of the party submiting the evidence. Note that 0x0 refers to evidence not submitted by any party.
     *  @param _evidence A URI to the evidence JSON file whose name should be its keccak256 hash followed by .json.
     */
    event Evidence(Arbitrator indexed _arbitrator, uint indexed _evidenceGroupID, address indexed _party, string _evidence);

    /** @dev To be raised when a ruling is given.
     *  @param _arbitrator The arbitrator giving the ruling.
     *  @param _disputeID ID of the dispute in the Arbitrator contract.
     *  @param _ruling The ruling which was given.
     */
    event Ruling(Arbitrator indexed _arbitrator, uint indexed _disputeID, uint _ruling);

    /** @dev Give a ruling for a dispute. Must be called by the arbitrator.
     *  The purpose of this function is to ensure that the address calling it has the right to rule on the contract.
     *  @param _disputeID ID of the dispute in the Arbitrator contract.
     *  @param _ruling Ruling given by the arbitrator. Note that 0 is reserved for "Not able/wanting to make a decision".
     */
    function rule(uint _disputeID, uint _ruling) external;
}

contract Arbitrable is IArbitrable {
    Arbitrator public arbitrator;
    bytes public arbitratorExtraData; // Extra data to require particular dispute and appeal behaviour.

    modifier onlyArbitrator {require(msg.sender == address(arbitrator), "Can only be called by the arbitrator."); _;}

    /** @dev Constructor. Choose the arbitrator.
     *  @param _arbitrator The arbitrator of the contract.
     *  @param _arbitratorExtraData Extra data for the arbitrator.
     */
    constructor(Arbitrator _arbitrator, bytes memory _arbitratorExtraData) public {
        arbitrator = _arbitrator;
        arbitratorExtraData = _arbitratorExtraData;
    }

    /** @dev Give a ruling for a dispute. Must be called by the arbitrator.
     *  The purpose of this function is to ensure that the address calling it has the right to rule on the contract.
     *  @param _disputeID ID of the dispute in the Arbitrator contract.
     *  @param _ruling Ruling given by the arbitrator. Note that 0 is reserved for "Not able/wanting to make a decision".
     */
    function rule(uint _disputeID, uint _ruling) public onlyArbitrator {
        emit Ruling(Arbitrator(msg.sender),_disputeID,_ruling);

        executeRuling(_disputeID,_ruling);
    }


    /** @dev Execute a ruling of a dispute.
     *  @param _disputeID ID of the dispute in the Arbitrator contract.
     *  @param _ruling Ruling given by the arbitrator. Note that 0 is reserved for "Not able/wanting to make a decision".
     */
    function executeRuling(uint _disputeID, uint _ruling) internal;
}

contract Arbitrator {

    enum DisputeStatus {Waiting, Appealable, Solved}

    modifier requireArbitrationFee(bytes memory _extraData) {
        require(msg.value >= arbitrationCost(_extraData), "Not enough ETH to cover arbitration costs.");
        _;
    }
    modifier requireAppealFee(uint _disputeID, bytes memory _extraData) {
        require(msg.value >= appealCost(_disputeID, _extraData), "Not enough ETH to cover appeal costs.");
        _;
    }

    /** @dev To be raised when a dispute is created.
     *  @param _disputeID ID of the dispute.
     *  @param _arbitrable The contract which created the dispute.
     */
    event DisputeCreation(uint indexed _disputeID, Arbitrable indexed _arbitrable);

    /** @dev To be raised when a dispute can be appealed.
     *  @param _disputeID ID of the dispute.
     */
    event AppealPossible(uint indexed _disputeID, Arbitrable indexed _arbitrable);

    /** @dev To be raised when the current ruling is appealed.
     *  @param _disputeID ID of the dispute.
     *  @param _arbitrable The contract which created the dispute.
     */
    event AppealDecision(uint indexed _disputeID, Arbitrable indexed _arbitrable);

    /** @dev Create a dispute. Must be called by the arbitrable contract.
     *  Must be paid at least arbitrationCost(_extraData).
     *  @param _choices Amount of choices the arbitrator can make in this dispute.
     *  @param _extraData Can be used to give additional info on the dispute to be created.
     *  @return disputeID ID of the dispute created.
     */
    function createDispute(uint _choices, bytes memory _extraData) public requireArbitrationFee(_extraData) payable returns(uint disputeID) {}

    /** @dev Compute the cost of arbitration. It is recommended not to increase it often, as it can be highly time and gas consuming for the arbitrated contracts to cope with fee augmentation.
     *  @param _extraData Can be used to give additional info on the dispute to be created.
     *  @return fee Amount to be paid.
     */
    function arbitrationCost(bytes memory _extraData) public view returns(uint fee);
    

    /** @dev Appeal a ruling. Note that it has to be called before the arbitrator contract calls rule.
     *  @param _disputeID ID of the dispute to be appealed.
     *  @param _extraData Can be used to give extra info on the appeal.
     */
    function appeal(uint _disputeID, bytes memory _extraData) public requireAppealFee(_disputeID,_extraData) payable {
        emit AppealDecision(_disputeID, Arbitrable(msg.sender));
    }

    /** @dev Compute the cost of appeal. It is recommended not to increase it often, as it can be higly time and gas consuming for the arbitrated contracts to cope with fee augmentation.
     *  @param _disputeID ID of the dispute to be appealed.
     *  @param _extraData Can be used to give additional info on the dispute to be created.
     *  @return fee Amount to be paid.
     */
    function appealCost(uint _disputeID, bytes memory _extraData) public view returns(uint fee);

    /** @dev Compute the start and end of the dispute's current or next appeal period, if possible.
     *  @param _disputeID ID of the dispute.
     *  @return The start and end of the period.
     */
    function appealPeriod(uint _disputeID) public view returns(uint start, uint end) {}

    /** @dev Return the status of a dispute.
     *  @param _disputeID ID of the dispute to rule.
     *  @return status The status of the dispute.
     */
    function disputeStatus(uint _disputeID) public view returns(DisputeStatus status);

    /** @dev Return the current ruling of a dispute. This is useful for parties to know if they should appeal.
     *  @param _disputeID ID of the dispute.
     *  @return ruling The ruling which has been given or the one which will be given if there is no appeal.
     */
    function currentRuling(uint _disputeID) public view returns(uint ruling);
}
   
   
contract LogicalPuzzlesArbitrable is IArbitrable {
    using SafeMath for uint256;
    
    enum Result {NOTHING, WAITING_CREATOR, WAITING_PLAYER, DISPUTE_CREATED, PLAYER_WINS, CREATOR_WINS, NO_WINNER}
    
    enum Appeal {NO_APPEAL, PLAYER_APPEAL, CREATOR_APPEAL}
    
    uint8 constant AMOUNT_OF_CHOICES = 2;
    uint8 constant PLAYER_WINS = 1;
    uint8 constant CREATOR_WINS = 2;

    event MetaEvidence(uint indexed _metaEvidenceID, string _evidence);
    
    event Dispute(Arbitrator indexed _arbitrator, uint indexed _disputeID, uint _metaEvidenceID, uint _evidenceGroupID);
    
    event Evidence(Arbitrator indexed _arbitrator, uint indexed _evidenceGroupID, address indexed _party, string _evidence);
    
    event Ruling(Arbitrator indexed _arbitrator, uint indexed _disputeID, uint _ruling);
    
    StoragePuzzlesAbstract storagepuzzles;
    
    modifier onlyOtherLogicalContracts(uint256 _logicalContractIndex) {
        require (_logicalContractIndex<storagepuzzles.getLogicalContractLength(), "Logical contract index not present");
        require (storagepuzzles.getLogicalContract(_logicalContractIndex)==msg.sender, "Sender different from logical contract");
        _;
    }
    
    constructor (address payable _storagepuzzles) public {
        storagepuzzles=StoragePuzzlesAbstract(_storagepuzzles);
    }
    
  
    
   
    
    function raiseDispute (uint256 _logicalContractIndex, uint256 _gameIndex, address payable _player, uint256 _arbitrationCost) onlyOtherLogicalContracts(_logicalContractIndex) external  {
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        storagepuzzles.setOfferSolutionResult(2,_gameIndex,indexoffer,uint256(Result.DISPUTE_CREATED));
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        bytes memory arbitratorExtraData=storagepuzzles.getarbitratorExtraData();
        storagepuzzles.transferEth(2,address(this), _arbitrationCost);
        uint256 disputeid=arbitrator.createDispute.value(_arbitrationCost)(AMOUNT_OF_CHOICES, arbitratorExtraData);
        storagepuzzles.setOfferDisputeId(2,_gameIndex,indexoffer,disputeid);
        storagepuzzles.setDisputeIDtoArbitrationIndexIDGameIndex(2,disputeid,_gameIndex);
        storagepuzzles.setDisputeIDtoArbitrationIndexIDPlayer(2,disputeid,_player);
        storagepuzzles.setOfferTimeDispute(2,_gameIndex,indexoffer,now);
        emit Dispute(arbitrator, disputeid, _gameIndex, uint256(keccak256(abi.encodePacked(_gameIndex,storagepuzzles.getGameCreator(_gameIndex),_player))));
        // Refund sender if it overpaid.
        uint256 playerfee=storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer);
        if (playerfee > _arbitrationCost) {
            uint256 extraFeeplayer = playerfee-_arbitrationCost;
            storagepuzzles.setOfferPlayerFee(2,_gameIndex,indexoffer,_arbitrationCost);
            storagepuzzles.transferEth(2,_player,extraFeeplayer);
        }
        // Refund receiver if it overpaid.
        uint256 creatorfee=storagepuzzles.getOfferCreatorFee(_gameIndex,indexoffer);
        if (creatorfee > _arbitrationCost) {
            uint256 extraFeeCreator = creatorfee - _arbitrationCost;
            storagepuzzles.setOfferCreatorFee(2,_gameIndex,indexoffer,_arbitrationCost);
            storagepuzzles.transferEth(2,storagepuzzles.getGameCreator(_gameIndex),extraFeeCreator);
        }
    }
    
    function submitEvidencePlayer(uint256 _gameIndex, string calldata _evidence) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedGame(_gameIndex)==true, "game not created");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        require(storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) <= uint256(Result.DISPUTE_CREATED), "Must not send evidence if the dispute is resolved.");
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        emit Evidence(arbitrator, uint256(keccak256(abi.encodePacked(_gameIndex,storagepuzzles.getGameCreator(_gameIndex),msg.sender))), msg.sender, _evidence);
    }
    
    
    function submitEvidenceCreator(uint256 _gameIndex, address _player, string calldata _evidence) external {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution not submitted");
        require (storagepuzzles.getOffersMapSubmittedOffer(_gameIndex,_player)==true, "offer not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        require(storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) <= uint256(Result.DISPUTE_CREATED), "Must not send evidence if the dispute is resolved.");
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        emit Evidence(arbitrator,  uint256(keccak256(abi.encodePacked(_gameIndex,msg.sender,_player))), msg.sender, _evidence);
    }
    
    function appealPlayer(uint256 _gameIndex) external payable {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "game not created");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        uint256 grosswin = storagepuzzles.getOfferExpectedWin(_gameIndex,indexoffer);
        uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex,indexoffer);
        uint256 netwin = grosswin-fee;
        uint256 valuebet=(grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex);
        uint256 disputestatus;
        uint256 currentruling;
        uint256 startimeAppeal;
        uint256 endtimeAppeal;
        uint256 appealcost;
        (disputestatus, currentruling, startimeAppeal, endtimeAppeal, appealcost)=GetAppealInfo(_gameIndex, msg.sender);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) == uint256(Result.DISPUTE_CREATED), "Dispute not open");
        require (storagepuzzles.getOfferAppeal(_gameIndex,indexoffer) == uint256(Appeal.NO_APPEAL),"Appeal yet submitted");
        require (disputestatus==1, "Dispute not appellable");
        require (now>=startimeAppeal && now<=endtimeAppeal , "Appeal interval not correct");
        require (msg.value>=appealcost, "Appeal cost too high");
        require (currentruling!=1, "Ruling favorable");
        if (currentruling==2) {
            require (appealcost < netwin+storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer),"appeal not profitable");
        } else {
            require (appealcost < netwin.sub(valuebet)+(fee/2)+(storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer)/2),"appeal not profitable");
        }
        if (msg.value > appealcost) {
            msg.sender.transfer(msg.value-appealcost);
        }
        storagepuzzles.setOfferTimeDispute(2,_gameIndex,indexoffer,now);
        storagepuzzles.setOfferAppeal(2,_gameIndex,indexoffer,uint256(Appeal.PLAYER_APPEAL));
        storagepuzzles.setOfferAppealFee(2,_gameIndex,indexoffer,appealcost);
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        bytes memory arbitratorExtraData=storagepuzzles.getarbitratorExtraData();
        uint256 disputeid=storagepuzzles.getOfferDisputeId(_gameIndex,indexoffer);
        arbitrator.appeal.value(appealcost)(disputeid, arbitratorExtraData);
    }
    
    function appealCreator(uint256 _gameIndex, address _player) external payable {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "game not created");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true, "solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        uint256 grosswin = storagepuzzles.getOfferExpectedWin(_gameIndex,indexoffer);
        uint256 fee=storagepuzzles.getOfferServiceFee(_gameIndex,indexoffer);
        uint256 netwin = grosswin-fee;
        uint256 disputestatus;
        uint256 currentruling;
        uint256 startimeAppeal;
        uint256 endtimeAppeal;
        uint256 appealcost;
        (disputestatus, currentruling, startimeAppeal, endtimeAppeal, appealcost)=GetAppealInfo(_gameIndex, _player);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer) == uint256(Result.DISPUTE_CREATED), "Dispute not open");
        require (storagepuzzles.getOfferAppeal(_gameIndex,indexoffer) == uint256(Appeal.NO_APPEAL),"Appeal yet submitted");
        require (disputestatus==1,"Dispute not appellable");
        require (now>=startimeAppeal && now<=endtimeAppeal, "Appeal interval not correct" );
        require (msg.value>=appealcost, "Appeal cost too high");
        require (currentruling!=2, "Ruling favorable");
        if (currentruling==1) {
            require (appealcost < netwin+storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer),"appeal not profitable");
        } else {
            require (appealcost < ((grosswin.mul(100))/storagepuzzles.getGameQuote(_gameIndex)).sub(fee/2)+(storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer)/2),"appeal not profitable");
        }
        if (msg.value>appealcost) {
            msg.sender.transfer(msg.value-appealcost);   
        }
        storagepuzzles.setOfferTimeDispute(2,_gameIndex,indexoffer,now);
        storagepuzzles.setOfferAppeal(2,_gameIndex,indexoffer,uint256(Appeal.CREATOR_APPEAL));
        storagepuzzles.setOfferAppealFee(2,_gameIndex,indexoffer,appealcost);
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        bytes memory arbitratorExtraData=storagepuzzles.getarbitratorExtraData();
        uint256 disputeid=storagepuzzles.getOfferDisputeId(_gameIndex,indexoffer);
        arbitrator.appeal.value(appealcost)(disputeid, arbitratorExtraData);
    }
    
    function GetAppealInfo(uint256 _gameIndex, address _player) public view returns (uint256 _disputestatus, uint256 _currentruling, uint256 _startimeAppeal, uint256 _endtimeAppeal, uint256 _appealcost) {
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true, "solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        uint256 disputeid=storagepuzzles.getOfferDisputeId(_gameIndex,indexoffer);
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        bytes memory arbitratorExtraData=storagepuzzles.getarbitratorExtraData();
        _disputestatus=uint256(arbitrator.disputeStatus(disputeid));
        _currentruling=arbitrator.currentRuling(disputeid);
        (_startimeAppeal,_endtimeAppeal)=arbitrator.appealPeriod(disputeid);
        _appealcost=arbitrator.appealCost(disputeid,arbitratorExtraData);
    }
 
    
    function rule(uint256 _disputeID, uint _ruling) external {
        uint256 gameindex=storagepuzzles.getDisputeIDtoArbitrationIndexIDGameIndex(_disputeID);
        require (gameindex<storagepuzzles.getGamesLength(), "Game index not correct");
        address payable player=storagepuzzles.getDisputeIDtoArbitrationIndexIDPlayer(_disputeID);
        require (storagepuzzles.getOffersMapSubmittedSol(gameindex,player)==true, "offer not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(gameindex, player);
        require(msg.sender == storagepuzzles.getArbitratorAddress(), "The caller must be the arbitrator.");
        require(storagepuzzles.getOfferSolutionResult(gameindex,indexoffer) == uint256(Result.DISPUTE_CREATED), "The dispute has already been resolved.");
        //require(now <= storagepuzzles.getOfferTimeDispute(gameindex,indexoffer).add(storagepuzzles.getTimeoutRuling()), "Ruling timeout activated");
        emit Ruling(Arbitrator(msg.sender), _disputeID, _ruling);
        LogicalPuzzlesDisputeWithdrawAbstract logicalpuzzlesdisputewithdraw =LogicalPuzzlesDisputeWithdrawAbstract(storagepuzzles.getLogicalContract(4));
        logicalpuzzlesdisputewithdraw.executeRulingExternal(2,gameindex, player, _ruling);
    }
    
  
    
    function emitMetaEvidence(uint256 _logicalContractIndex, uint256 _metaEvidenceID, string calldata _evidence) onlyOtherLogicalContracts(_logicalContractIndex) external {
        emit MetaEvidence(_metaEvidenceID,_evidence);
    }
   
   
    function () external payable {}
}