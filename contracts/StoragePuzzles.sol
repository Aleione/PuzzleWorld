pragma solidity ^0.5.0;

contract OwnableDao {
    address internal ownerDao;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    constructor (address _ownerDao) internal {
        require (_ownerDao!=address(0));
        ownerDao = _ownerDao;
        emit OwnershipTransferred(address(0), _ownerDao);
    }



    /**
     * @return the address of the owner.
     */
    function getOwnerDao() public view returns (address) {
        return ownerDao;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwnerDao() {
        require(isOwnerDao());
        _;
    }

    /**
     * @return true if `msg.sender` is the owner of the contract.
     */
    function isOwnerDao() public view returns (bool) {
        return msg.sender == ownerDao;
    }

   
    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwnerDao The address to transfer ownership to.
     */
    function transferOwnershipDao(address newOwnerDao) public onlyOwnerDao {
        _transferOwnershipDao(newOwnerDao);
    }

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwnerDao The address to transfer ownership to.
     */
    function _transferOwnershipDao(address newOwnerDao) internal {
        require(newOwnerDao != address(0));
        emit OwnershipTransferred(ownerDao, newOwnerDao);
        ownerDao = newOwnerDao;
    }
}


contract StoragePuzzles is OwnableDao {
    
    struct Game {
        uint32 gameType;
        address payable creator;
        uint256 residualJackpot;
        uint256 maxOffer;
        uint256 minOffer;
        uint256 maxOfferNumber;
        uint256 timePropose;
        uint256 timeoutOffer;
        uint256 timeCreationGame;
        uint256 timeoutResolution;
        uint256 quote;
        bytes32 solutionHash;
        string  solution;
    }
        
    Game[] private games;
    
    mapping(uint256=>string) private gameMetadata;
    
        
    enum Result {NOTHING, WAITING_CREATOR, WAITING_PLAYER, DISPUTE_CREATED, PLAYER_WINS, CREATOR_WINS, NO_WINNER}
    
    enum Appeal {NO_APPEAL, PLAYER_APPEAL, CREATOR_APPEAL}
        
    struct Offer {
        address payable player;
        uint256 expectedWin;
        uint256 serviceFee;
        bytes32 solutionHash;
        string solutionPlayer;
        uint256 lastInteraction; 
        Result solutionResult;
        uint256 disputeId; // If dispute exists, the ID of the dispute.
        uint256 timeDispute;
        uint256 playerFee; // Total fees paid by the player in case of dispute
        uint256 creatorFee; // Total fees paid by the creator in case of dispute
        Appeal appeal;
        uint256 appealFee;
    }
        
    mapping  (uint256 => Offer[]) private gameOffers;
    
        
    struct FlagAndPositionPlayer {
        uint256 indexOffer;
        bool submittedOffer;
        bool submittedHashSol;
        bool submittedSol;
    }
    
    mapping  (uint256 => mapping (address  => FlagAndPositionPlayer )) private offersMap;
    
    
    struct FlagAndPositionCreator {
        bool submittedGame;
        bool submittedSol;
    }
    
    mapping  (uint256  => FlagAndPositionCreator ) private creationMap;
    
    
    struct GameAndPlayer  {
        uint256 gameIndex;
        address payable player;
    }
    
    mapping (uint256 => GameAndPlayer) private disputeIDtoArbitrationIndexID;
    
    uint256 private feeBalance;
    
    
    bool[] private gamesType;
    
    uint256 private minimalJackpot;
    
    uint256 private maxTimeoutCreation;
    
    uint256 private timeoutPlayerSolution;
    
    uint256 private timeoutCreatorSolution;
    
    uint256 private timeoutDisp;
    
    uint256 private timeoutRuling;
    
    uint256 private feePercent;
    
    address private arbitratorAddress;
    
    bytes private   arbitratorExtraData;
    
    uint256 private feeTimeout;
    
    address[] private logicalContracts;
    
    modifier onlyLogicalContract(uint256 _logicalContractIndex) {
        require (_logicalContractIndex<logicalContracts.length, "Logical contract index not present");
        require (logicalContracts[_logicalContractIndex]==msg.sender, "Sender different from logical contract");
        _;
    }
    
    
    constructor (address _arbitratorAddress, bytes memory _arbitratorExtraData, uint256 _minimalJackpot, uint256 _maxTimeoutCreation, uint256 _timeoutPlayerSolution, uint256 _timeoutCreatorSolution, uint256 _timeoutDisp, uint256 _timeoutRuling, uint256 _feePercent, uint256 _feeTimeout, address _ownerDao) public OwnableDao(_ownerDao)    {
        require (_feePercent<10000);
        require (_arbitratorAddress!=address(0));
        require (_maxTimeoutCreation!=0);
        require (_timeoutPlayerSolution!=0);
        require (_timeoutCreatorSolution!=0);
        require (_timeoutDisp!=0);
        require (_timeoutRuling!=0);
        require (_feeTimeout!=0);
        arbitratorAddress=_arbitratorAddress;
        arbitratorExtraData=_arbitratorExtraData;
        minimalJackpot=_minimalJackpot;
        maxTimeoutCreation=_maxTimeoutCreation;
        timeoutPlayerSolution=_timeoutPlayerSolution;
        timeoutCreatorSolution=_timeoutCreatorSolution;
        timeoutDisp=_timeoutDisp;
        timeoutRuling=_timeoutRuling;
        feePercent= _feePercent;
        feeTimeout=_feeTimeout;
    }
    
    function AddGamesType (bool _gameActivated) onlyOwnerDao() external {
        gamesType.push(_gameActivated);
    }
    
    function SetGameType (bool _gameActivated, uint256 _gameTypeIndex) onlyOwnerDao() external  {
        require (_gameTypeIndex<gamesType.length , "gametype index not valid");
        gamesType[_gameTypeIndex]=_gameActivated;
    }
    
    function GetGameType (uint256 _gameTypeIndex) external view returns (bool)  {
        return gamesType[_gameTypeIndex];
    }
    
    function GetGameTypeLength ()  external view returns (uint256)  {
        return gamesType.length;
    }
    
    function setMinimalJackpot (uint256 _minimalJackpot) onlyOwnerDao() external {
        minimalJackpot= _minimalJackpot;
    }
    
    function getMinimalJackpot() external view returns(uint256) {
        return minimalJackpot;
    }
    
    function setMaxTimeoutCreation (uint256 _maxTimeoutCreation)  onlyOwnerDao() external {
        require (_maxTimeoutCreation!=0);
        maxTimeoutCreation=_maxTimeoutCreation;
    }
    
    function getMaxTimeoutCreation () external view returns(uint256) {
        return maxTimeoutCreation;
    }
    
    function setTimeoutPlayerSolution (uint256 _timeoutPlayerSolution) onlyOwnerDao() external {
        require (_timeoutPlayerSolution!=0);
        timeoutPlayerSolution=_timeoutPlayerSolution;
    }
    
    function getTimeoutPlayerSolution () external view returns(uint256) {
        return timeoutPlayerSolution;
    }
    
    function setTimeoutCreatorSolution (uint256 _timeoutCreatorSolution) onlyOwnerDao() external {
        require (_timeoutCreatorSolution!=0);
        timeoutCreatorSolution=_timeoutCreatorSolution;
    }
    
    function getTimeoutCreatorSolution () external view returns(uint256) {
        return timeoutCreatorSolution ;
    }
        
    function setTimeoutDisp (uint256 _timeoutDisp) onlyOwnerDao() external {
        require (_timeoutDisp!=0);
        timeoutDisp=_timeoutDisp;
    } 
    
    function getTimeoutDisp () external view returns(uint256) {
        return timeoutDisp;
    } 
    
    function setTimeoutRuling (uint256 _timeoutRuling) onlyOwnerDao() external  {
        require (_timeoutRuling!=0);
        timeoutRuling= _timeoutRuling;
    }
    
    function getTimeoutRuling () external view returns(uint256) {
        return timeoutRuling;
    }
    
    function setFeePercent (uint256 _feePercent) onlyOwnerDao() external {
        require (_feePercent<10000);
        feePercent=_feePercent;
    }
    
    function getFeePercent () external view returns(uint256) {
        return feePercent;
    }
    
    function setFeeTimeout(uint256 _feeTimeout) onlyOwnerDao() external {
        require (_feeTimeout!=0);
        feeTimeout=_feeTimeout;
    }
    
    function getFeeTimeout() external view returns(uint256) {
        return feeTimeout;
    }
 
    function setArbitrator (address _arbitratorAddress, bytes calldata _arbitratorExtraData) onlyOwnerDao() external {
        require (_arbitratorAddress!=address(0));
        arbitratorAddress=_arbitratorAddress;
        arbitratorExtraData=_arbitratorExtraData;
    }
    
    function getArbitratorAddress() external view returns(address) {
        return arbitratorAddress;
    }
    
    function getarbitratorExtraData() external view returns(bytes memory) {
        return arbitratorExtraData;
    }
    
    
    function addLogicalContract (address _logicalContract) onlyOwnerDao() external {
        require (_logicalContract!=address(0));
        logicalContracts.push(_logicalContract);
    }
    
    function setLogicalContract (address _logicalContract, uint256 _logicalContractIndex) onlyOwnerDao() external {
        require (_logicalContractIndex<logicalContracts.length);
        require (_logicalContract!=address(0));
        logicalContracts[_logicalContractIndex]=_logicalContract;
    }
    
    function getLogicalContract (uint256 _logicalContractIndex) external view returns(address)  {
        return logicalContracts[_logicalContractIndex];
    }
    
    function getLogicalContractLength () external view returns(uint256) {
        return logicalContracts.length;
    }
    
    function withdrawFee (address payable _destination, uint256 _amount) onlyOwnerDao() external {
        require (_amount<=feeBalance, "feebalance less than amount to withdraw");
        require (_destination!=address(0));
        _destination.transfer(_amount); 
        feeBalance=feeBalance-_amount;
    }
    
//----------------------------------------------------------------------------------------------------    
    
    
    function addGame (uint256 _logicalContractIndex, uint32  _gameType,  address payable _creator, uint256 _residualJackpot,  uint256[3] calldata _gameLimits, uint256[2] calldata _timeouts, uint256[2] calldata _times, uint256 _quote, bytes32 _solutionHash, string calldata _solution)  onlyLogicalContract(_logicalContractIndex) external {
        Game memory game=Game(_gameType, _creator, _residualJackpot, _gameLimits[0], _gameLimits[1], _gameLimits[2], _times[0] , _timeouts[0], _times[1], _timeouts[1], _quote, _solutionHash , _solution);
        games.push(game);
    }
    
    function setGameType (uint256 _logicalContractIndex, uint256 _gameIndex, uint32 _gameType) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].gameType=_gameType;
    }
    
    function setGameCreator (uint256 _logicalContractIndex, uint256 _gameIndex, address payable _creator) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].creator=_creator;
    }
    
    function setGameResidualJackpot (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _residualJackpot) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].residualJackpot=_residualJackpot;
    }
    
    function setGameMaxOffer (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _maxOffer) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].maxOffer=_maxOffer;
    }
    
    function  setGameMinOffer (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _minOffer) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].minOffer=_minOffer;
    }
    
    function setGameMaxOfferNumber (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _maxOfferNumber) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].maxOfferNumber=_maxOfferNumber;
    }
    
    function setTimePropose (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timePropose) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].timePropose=_timePropose;
    }
    
    function setGametimeoutOffer(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timeoutOffer) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].timeoutOffer=_timeoutOffer;
    }
    
    function setGameTimeCreationGame(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timeCreationGame) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].timeCreationGame=_timeCreationGame;
    }
    
    function setGameTimeoutResolution(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _timeoutResolution) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].timeoutResolution=_timeoutResolution;
    }
    
   
    
    function setGameQuote(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _quote) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].quote=_quote;
    }
    
    function setGameSolutionHash(uint256 _logicalContractIndex, uint256 _gameIndex, bytes32 _solutionHash) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].solutionHash=_solutionHash;
    }
    
    function setGameSolution(uint256 _logicalContractIndex, uint256 _gameIndex, string calldata _solution) onlyLogicalContract(_logicalContractIndex) external {
        games[_gameIndex].solution=_solution;
    }
    
    
    function getGameType (uint256 _gameIndex) external view returns(uint32)  {
        return games[_gameIndex].gameType;
    }
    
    function getGameCreator (uint256 _gameIndex) external view returns(address payable)  {
        return games[_gameIndex].creator;
    }
    
    function getGameResidualJackpot (uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].residualJackpot;
    }
    
    function getGameMaxOffer(uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].maxOffer;
    }
    
    function getGameMinOffer (uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].minOffer;
    }
    
    function getGameMaxOfferNumber (uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].maxOfferNumber;
    }
    
    function getGameTimePropose (uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].timePropose;
    }
    
    function getGameTimeoutOffer (uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].timeoutOffer;
    }
    
    function getGameTimeCreationGame(uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].timeCreationGame;
    }
    
    function getGameTimeoutResolution (uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].timeoutResolution;
    }
    
    function getGameQuote (uint256 _gameIndex) external view returns(uint256)  {
        return games[_gameIndex].quote;
    }
    
    function getGameSolutionHash (uint256 _gameIndex) external view returns(bytes32)  {
        return games[_gameIndex].solutionHash;
    }
    
    function getGameSolution (uint256 _gameIndex) external view returns(string memory)  {
        return games[_gameIndex].solution;
    }
    
    function getGamesLength ()  external view returns(uint256) {
        return games.length;
    }
    
//    ------------------------------------------------------------------------
   
    
    
    function setGameMetadata (uint256 _logicalContractIndex, uint256 _gameIndex, string calldata _gameMetadata) onlyLogicalContract(_logicalContractIndex) external {
        gameMetadata[_gameIndex]=_gameMetadata;
    }
    
    function getGameMetadata(uint256 _gameIndex) external view returns(string memory) {
        return gameMetadata[_gameIndex];
    }

    
    
 //   ----------------------------------------------------------------------------
    
    
    function addOffer (uint256 _logicalContractIndex, uint256 _gameIndex, address payable _player, uint256 _expectedwin, uint256 _serviceFee, bytes32 _solutionHash, string calldata _solutionPlayer, uint256 _lastInteraction, uint256 _solutionResult, uint256[6] calldata _disputeFields) onlyLogicalContract(_logicalContractIndex) external {
        Offer memory offer = Offer( _player, _expectedwin, _serviceFee, _solutionHash, _solutionPlayer, _lastInteraction, Result(_solutionResult), _disputeFields[0], _disputeFields[1], _disputeFields[2],  _disputeFields[3], Appeal(_disputeFields[4]), _disputeFields[5]);
        gameOffers[_gameIndex].push(offer);
    }
    
    function setOfferPlayer (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, address payable _player)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.player=_player;
    }
    
    function setOfferExpectedWin (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _expectedWin)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.expectedWin=_expectedWin;
    }
    
    function setOfferServiceFee (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _serviceFee)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.serviceFee=_serviceFee;
    }
    
    function setOfferSolutionHash (uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, bytes32 _solutionHash)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.solutionHash=_solutionHash;
    }
        
    function setOfferSolutionPlayer(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, string calldata _solutionPlayer)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.solutionPlayer=_solutionPlayer;
    }
    
    function setOfferLastInteraction(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _lastInteraction)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.lastInteraction=_lastInteraction;
    }
    
    function setOfferSolutionResult(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _solutionResult)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.solutionResult=Result(_solutionResult);
    }
    
    function setOfferDisputeId(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _disputeId)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.disputeId=_disputeId;
    }
	
    function setOfferTimeDispute(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _timeDispute) onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.timeDispute=_timeDispute;
    }
    
    function setOfferPlayerFee(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _playerFee)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.playerFee=_playerFee;
    }
    
    function setOfferCreatorFee(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _creatorFee)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.creatorFee=_creatorFee;
    }
    
    function setOfferAppeal(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _appeal)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.appeal=Appeal(_appeal);
    }
    
    function setOfferAppealFee(uint256 _logicalContractIndex, uint256 _gameIndex, uint256 _offerIndex, uint256 _appealFee)  onlyLogicalContract(_logicalContractIndex) external {
        Offer storage offer=gameOffers[_gameIndex][_offerIndex];
        offer.appealFee=_appealFee;
    }
    
    function getOfferPlayer (uint256 _gameIndex, uint256 _offerIndex) external view returns(address payable)  {
        return gameOffers[_gameIndex][_offerIndex].player;
    }
    
    function getOfferExpectedWin (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].expectedWin;
    }
    
    function getOfferServiceFee (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].serviceFee;
    }
    
    function getOfferSolutionHash (uint256 _gameIndex, uint256 _offerIndex) external view returns(bytes32)  {
        return gameOffers[_gameIndex][_offerIndex].solutionHash;
    }
    
    function getOfferSolutionPlayer (uint256 _gameIndex, uint256 _offerIndex) external view returns(string memory)  {
        return gameOffers[_gameIndex][_offerIndex].solutionPlayer;
    }
    
    function getOfferLastInteraction (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].lastInteraction;
    }
    
    function getOfferSolutionResult (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return uint256(gameOffers[_gameIndex][_offerIndex].solutionResult);
    }
    
    function getOfferDisputeId (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].disputeId;
    }
	
    function getOfferTimeDispute (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].timeDispute;
    }
    
    function getOfferPlayerFee (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].playerFee;
    }
    
    function getOfferCreatorFee (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].creatorFee;
    }
    
    function getOfferAppeal (uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return uint256(gameOffers[_gameIndex][_offerIndex].appeal);
    }
    
    function getOfferAppealFee(uint256 _gameIndex, uint256 _offerIndex) external view returns(uint256)  {
        return gameOffers[_gameIndex][_offerIndex].appealFee;
    }
      
    function getOffersLength (uint256 _gameIndex)  external view returns(uint256) {
        return gameOffers[_gameIndex].length;
    }
    
    
//---------------------------------------------------------------------
    
    
    function addOffersMap (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, uint256 _indexOffer, bool _submittedOffer, bool _submittedHashSol, bool _submittedSol) onlyLogicalContract(_logicalContractIndex) external {
        FlagAndPositionPlayer memory flagandpositionplayer = FlagAndPositionPlayer(_indexOffer, _submittedOffer, _submittedHashSol, _submittedSol);
        offersMap[_gameIndex][_player]=flagandpositionplayer;
    }
    
    
    function setOffersMapIndexOffer (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, uint256 _indexOffer) onlyLogicalContract(_logicalContractIndex) external {
        offersMap[_gameIndex][_player].indexOffer=_indexOffer;
    }
    
    function setOffersMapSubmittedOffer (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, bool _submittedOffer) onlyLogicalContract(_logicalContractIndex) external {
        offersMap[_gameIndex][_player].submittedOffer= _submittedOffer;
    }
    
    function setOffersMapSubmittedHashSol (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, bool _submittedHashSol) onlyLogicalContract(_logicalContractIndex) external {
        offersMap[_gameIndex][_player].submittedHashSol=_submittedHashSol;
    }
    
    function setOffersMapSubmittedSol (uint256 _logicalContractIndex, uint256 _gameIndex, address _player, bool _submittedSol) onlyLogicalContract(_logicalContractIndex) external {
        offersMap[_gameIndex][_player].submittedSol=_submittedSol;
    }
    
    function getOffersMapIndexOffer (uint256 _gameIndex, address _player) external view returns (uint256)  {
        return offersMap[_gameIndex][_player].indexOffer;
    }
    
    function getOffersMapSubmittedOffer(uint256 _gameIndex, address _player) external view returns (bool)  {
        return offersMap[_gameIndex][_player].submittedOffer;
    }
    
    function getOffersMapSubmittedHashSol (uint256 _gameIndex, address _player) external view returns (bool)  {
        return offersMap[_gameIndex][_player].submittedHashSol;
    }
    
    function getOffersMapSubmittedSol (uint256 _gameIndex, address _player) external view returns (bool)  {
        return offersMap[_gameIndex][_player].submittedSol;
    }
    
 
    
//-----------------------------------
    
 
 
    function addCreationMap (uint256 _logicalContractIndex, uint256 _gameIndex, bool _submittedGame, bool _submittedSol) onlyLogicalContract(_logicalContractIndex) external {
        FlagAndPositionCreator memory flagandpositioncreator = FlagAndPositionCreator(_submittedGame, _submittedSol);
        creationMap[_gameIndex]=flagandpositioncreator;
    }
    
    function setCreationMapSubmittedGame (uint256 _logicalContractIndex, uint256 _gameIndex, bool _submittedGame) onlyLogicalContract(_logicalContractIndex) external {
        creationMap[_gameIndex].submittedGame=_submittedGame;
    } 
    
    function setCreationMapSubmittedSol (uint256 _logicalContractIndex, uint256 _gameIndex, bool _submittedSol) onlyLogicalContract(_logicalContractIndex) external {
        creationMap[_gameIndex].submittedSol=_submittedSol;
    } 
    
    function getCreationMapSubmittedGame (uint256 _gameIndex) external view returns(bool) {
        return  creationMap[_gameIndex].submittedGame;
    }
    
    function getCreationMapSubmittedSol (uint256 _gameIndex) external view returns(bool) {
        return  creationMap[_gameIndex].submittedSol;
    }
    
  
    
//----------------------------------------------------------------
    
    
    function addDisputeIDtoArbitrationIndexID (uint256 _logicalContractIndex, uint256 _disputeId,  uint256 _gameIndex, address payable _player) onlyLogicalContract(_logicalContractIndex) external {
        GameAndPlayer memory gameandplayer=GameAndPlayer(_gameIndex, _player);
        disputeIDtoArbitrationIndexID[_disputeId]=gameandplayer;
    }
    
    function setDisputeIDtoArbitrationIndexIDGameIndex (uint256 _logicalContractIndex, uint256 _disputeId,  uint256 _gameIndex) onlyLogicalContract(_logicalContractIndex) external  {
        disputeIDtoArbitrationIndexID[_disputeId].gameIndex=_gameIndex;
    }
    
    function setDisputeIDtoArbitrationIndexIDPlayer (uint256 _logicalContractIndex, uint256 _disputeId,  address payable _player) onlyLogicalContract(_logicalContractIndex) external  {
        disputeIDtoArbitrationIndexID[_disputeId].player=_player;
    }
    
    function getDisputeIDtoArbitrationIndexIDGameIndex (uint256 _disputeId) external view returns(uint256) {
        return disputeIDtoArbitrationIndexID[_disputeId].gameIndex;
    }
    
    function getDisputeIDtoArbitrationIndexIDPlayer (uint256 _disputeId) external view returns(address payable) {
        return disputeIDtoArbitrationIndexID[_disputeId].player;
    }
   

    
 //----------------------------------------------------------------  
    
    function SetFeeBalance (uint256 _logicalContractIndex, uint256 _feeBalance) onlyLogicalContract(_logicalContractIndex) external {
        feeBalance=_feeBalance;
    }
    
    function getFeeBalance() external view returns(uint256) {
        return feeBalance;
    }
    
    function transferEth (uint256 _logicalContractIndex, address payable _destination, uint256 _amount) onlyLogicalContract(_logicalContractIndex) external {
        require (_destination!=address(0), "address null");
        require (_amount<=address(this).balance, "no enough ETH");
        _destination.transfer(_amount);
    }
    
    function () external payable {}
}
