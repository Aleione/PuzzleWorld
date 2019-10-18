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

contract LogicalPuzzlesArbitrableAbstract  {
    function raiseDispute (uint256 _logicalContractIndex, uint256 _gameIndex, address payable _player, uint256 _arbitrationCost) external;
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
  
   

   
contract LogicalPuzzlesInitialization {
    using SafeMath for uint256;
    
    enum Result {NOTHING, WAITING_CREATOR, WAITING_PLAYER, DISPUTE_CREATED, PLAYER_WINS, CREATOR_WINS, NO_WINNER}
    
    enum Appeal {NO_APPEAL, PLAYER_APPEAL, CREATOR_APPEAL}

   
    event HasToPayFee(uint256 indexed _gameId,  address indexed _payer, address indexed _disputeOtherSide, uint256 _minimalAmount);
    
    
    StoragePuzzlesAbstract public storagepuzzles;
    
    constructor (address payable _storagepuzzles) public {
        storagepuzzles=StoragePuzzlesAbstract(_storagepuzzles);
    }
    
    
 
 
 
    function getArbitrationCost () external view returns(uint256 arbitrationCost) {
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        bytes memory arbitratorExtraData=storagepuzzles.getarbitratorExtraData();
        arbitrationCost = arbitrator.arbitrationCost(arbitratorExtraData);
    }
    
    function payArbitrationFeeByPlayer(uint256 _gameIndex) external payable {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,msg.sender)==true, "Game solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, msg.sender);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)<uint256(Result.DISPUTE_CREATED)  ,"Dispute has already been created");
        if (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)==uint256(Result.NOTHING) )  {
            require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution game not created");
            require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()) && now<=storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()).add(storagepuzzles.getTimeoutDisp()), "timeout for arbitration start already activated");
            require (keccak256(abi.encodePacked(storagepuzzles.getGameSolution(_gameIndex))) != keccak256(abi.encodePacked(storagepuzzles.getOfferSolutionPlayer(_gameIndex,indexoffer))), "solution is correct" );
        }
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        bytes memory arbitratorExtraData=storagepuzzles.getarbitratorExtraData();
        uint256 arbitrationCost = arbitrator.arbitrationCost(arbitratorExtraData);
        storagepuzzles.setOfferPlayerFee(3,_gameIndex,indexoffer, storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer)+msg.value);
        // Require that the total pay at least the arbitration cost.
        require(storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer) >= arbitrationCost, "Player fee must cover arbitration costs.");
        address(storagepuzzles).transfer(msg.value);
        storagepuzzles.setOfferLastInteraction(3,_gameIndex,indexoffer,now);
        // The receiver still has to pay. This can also happen if he has paid, but arbitrationCost has increased. 
        uint256 offercreatorefee=storagepuzzles.getOfferCreatorFee(_gameIndex,indexoffer);
        if (offercreatorefee < arbitrationCost) {
            storagepuzzles.setOfferSolutionResult(3,_gameIndex,indexoffer,uint256(Result.WAITING_CREATOR)); 
            emit HasToPayFee(_gameIndex, storagepuzzles.getGameCreator(_gameIndex), msg.sender, arbitrationCost-offercreatorefee);
        } 
        else { // The receiver has also paid the fee. We create the dispute.
            LogicalPuzzlesArbitrableAbstract logicalpuzzlesarbitrable = LogicalPuzzlesArbitrableAbstract(storagepuzzles.getLogicalContract(2));
            logicalpuzzlesarbitrable.raiseDispute(3,_gameIndex, msg.sender, arbitrationCost);
        }
    }
    
    function payArbitrationFeeByCreator(uint256 _gameIndex, address payable  _player) external payable {
        require (_gameIndex<storagepuzzles.getGamesLength(), "Game index not correct");
        require (storagepuzzles.getGameCreator(_gameIndex)==msg.sender,"sender must be game creator");
        require (storagepuzzles.getOffersMapSubmittedSol(_gameIndex,_player)==true, "Game solution not submitted");
        uint256 indexoffer=storagepuzzles.getOffersMapIndexOffer(_gameIndex, _player);
        require (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)<uint256(Result.DISPUTE_CREATED)  ,"Dispute has already been created");
        if (storagepuzzles.getOfferSolutionResult(_gameIndex,indexoffer)==uint256(Result.NOTHING) )  {  
            require (storagepuzzles.getCreationMapSubmittedSol(_gameIndex)==true, "solution not submitted");
            require (now>storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()) && now<=storagepuzzles.getGameTimeCreationGame(_gameIndex).add(storagepuzzles.getGameTimeoutResolution(_gameIndex)).add(storagepuzzles.getTimeoutPlayerSolution()).add(storagepuzzles.getTimeoutCreatorSolution()).add(storagepuzzles.getTimeoutDisp()), "timeout for arbitration start already activated");
            require (keccak256(abi.encodePacked(storagepuzzles.getGameSolution(_gameIndex))) == keccak256(abi.encodePacked(storagepuzzles.getOfferSolutionPlayer(_gameIndex,indexoffer))), "solution is correct" );
        }
        Arbitrator arbitrator= Arbitrator(storagepuzzles.getArbitratorAddress());
        bytes memory arbitratorExtraData=storagepuzzles.getarbitratorExtraData();
        uint256 arbitrationCost = arbitrator.arbitrationCost(arbitratorExtraData);
        storagepuzzles.setOfferCreatorFee(3,_gameIndex,indexoffer, storagepuzzles.getOfferCreatorFee(_gameIndex,indexoffer)+msg.value);
        // Require that the total pay at least the arbitration cost.
        require(storagepuzzles.getOfferCreatorFee(_gameIndex,indexoffer) >= arbitrationCost, "Creator fee must cover arbitration costs.");
        address(storagepuzzles).transfer(msg.value);
        storagepuzzles.setOfferLastInteraction(3,_gameIndex,indexoffer,now);
        // The receiver still has to pay. This can also happen if he has paid, but arbitrationCost has increased. 
        uint256 offerplayerfee=storagepuzzles.getOfferPlayerFee(_gameIndex,indexoffer);
        if (offerplayerfee < arbitrationCost) {
            storagepuzzles.setOfferSolutionResult(3,_gameIndex,indexoffer,uint256(Result.WAITING_PLAYER));
            emit HasToPayFee(_gameIndex, _player, msg.sender, arbitrationCost-offerplayerfee);
        } 
        else { // The receiver has also paid the fee. We create the dispute.
            LogicalPuzzlesArbitrableAbstract logicalpuzzlesarbitrable = LogicalPuzzlesArbitrableAbstract(storagepuzzles.getLogicalContract(2));
            logicalpuzzlesarbitrable.raiseDispute(3,_gameIndex, _player, arbitrationCost);
        }
    }
}