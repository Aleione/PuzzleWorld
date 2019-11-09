pragma solidity ^0.5.0;

contract WfcManagment {
    function getOwnerDao() external view returns (address);
    function tokenAddress(address _tokenAddress) public view returns(bool);
    function serviceLines(string memory _line) public view returns(bool);
    function donationContract() public view returns(address);
}

contract WfcDonations {
    function createFundraising(string calldata _line, address _organization, uint256 _softcap, uint256 _hardcap, address _currency, uint256 _timeout, address _destination, string calldata _metadata) external;
}


contract HelpRequestOrganizations {
    
    WfcManagment public wfcManagment;
	
	enum StatusRegistration {NOT_EXISTING, PROPOSED, APPROVED, REFUSED, REVOKED, BLOCKED}
    
    struct OrganziationRef {
        string dataUrlPropose;
        StatusRegistration status;
        bool isUnderInvestigation;
        string dataUrlInvestigationRequest;
    }
    
    mapping(address => OrganziationRef) public organizations;
    
    event RegistrationRequestLog(address indexed _organizationAddress, string _dataUrl);
    
    event RegistrationApproved(address indexed _organizationAddress);
    
    event RegistrationRefused(address indexed _organizationAddress);
    
    event RegistrationRevoked(address indexed _organizationAddress);
    
    event RegitrationChanged(address indexed _previousAddress, address indexed _newAddress);
    
    event RequireDaoInvestigationLog(address indexed _organizationAddress, string _investigationDataUrl);
    
    event VoteDaoInvestigationLog(address indexed _organizationAddress, bool indexed _isBlocked);
    
	
	modifier onlyOwnerDao() {
	    address ownerDao = wfcManagment.getOwnerDao();
		require(msg.sender == ownerDao, 'sender is not Dao contract');
		_;
	}
	
	constructor(WfcManagment _wfcManagment) internal {
	    wfcManagment = _wfcManagment;
	}
    
    function registrationRequest(string calldata _dataUrl, address _organizationAddress) external {
        OrganziationRef storage organziationRef = organizations[_organizationAddress];
        require(organziationRef.status == StatusRegistration.NOT_EXISTING, 'Organization already proposed');
        OrganziationRef memory organziationRefTemp = OrganziationRef(_dataUrl, StatusRegistration.PROPOSED, false, '');
        organizations[_organizationAddress] = organziationRefTemp;
        emit RegistrationRequestLog(_organizationAddress, _dataUrl);
    }
    
    function approveRequest(address _organizationAddress) external onlyOwnerDao(){
        OrganziationRef storage organziationRef = organizations[_organizationAddress];
        require(organziationRef.status == StatusRegistration.PROPOSED, 'Organization not proposed');
        organziationRef.status = StatusRegistration.APPROVED;
        emit RegistrationApproved(_organizationAddress);
    }
    
    function refuseRequest(address _organizationAddress) external onlyOwnerDao(){
        OrganziationRef storage organziationRef = organizations[_organizationAddress];
        require(organziationRef.status == StatusRegistration.PROPOSED, 'Organization not proposed');
        organziationRef.status = StatusRegistration.REFUSED;
        emit RegistrationRefused(_organizationAddress);
    }
    
    function revokeAddress() external {
        OrganziationRef storage organziationRef = organizations[msg.sender];
        require(organziationRef.status == StatusRegistration.APPROVED, 'Organization not approved');
        organziationRef.status = StatusRegistration.REVOKED;
        emit RegistrationRevoked(msg.sender);
    }
    
    function changeAddress(address _newOrganizationAddress) external {
        OrganziationRef storage organziationRef = organizations[msg.sender];
        require(organziationRef.status == StatusRegistration.APPROVED, 'Organization not approved');
        require(!organziationRef.isUnderInvestigation, 'Organization under investigation');
        organizations[_newOrganizationAddress] = organziationRef;
        organziationRef.status = StatusRegistration.REVOKED;
        emit RegitrationChanged(msg.sender, _newOrganizationAddress);
    }
    
    function requireDaoInvestigation(string calldata _investigationDataUrl, address _organizationAddress) external {
        OrganziationRef storage organziationRef = organizations[_organizationAddress];
        require(organziationRef.status == StatusRegistration.APPROVED, 'Organization not approved');
        require(!organziationRef.isUnderInvestigation, 'Organization already under investigation');
        organziationRef.isUnderInvestigation = true;
        organziationRef.dataUrlInvestigationRequest = _investigationDataUrl;
        emit RequireDaoInvestigationLog(_organizationAddress, _investigationDataUrl);
    }
    
    function voteDaoInvestigation(address _organizationAddress, bool _isBlocked) external onlyOwnerDao() {
        OrganziationRef storage organziationRef = organizations[_organizationAddress];
        require(organziationRef.status == StatusRegistration.APPROVED, 'Organization not approved');
        require(organziationRef.isUnderInvestigation, 'Organization is not under investigation');
        if (_isBlocked) {
            organziationRef.status == StatusRegistration.BLOCKED;
            emit VoteDaoInvestigationLog(_organizationAddress, true);
        }
        else {
            organziationRef.isUnderInvestigation = false;
            organziationRef.dataUrlInvestigationRequest = '';
            emit VoteDaoInvestigationLog(_organizationAddress, false);
        }
    }
    
    function BlockHackedAddress(address _newOrganizationAddress) external {
        OrganziationRef storage organziationRefRevoked = organizations[msg.sender];
        OrganziationRef storage organziationRefChanged = organizations[_newOrganizationAddress];
        require(organziationRefRevoked.status == StatusRegistration.REVOKED, 'Organization sender not revoked');
        require(organziationRefChanged.status == StatusRegistration.APPROVED, 'Hacker organization not approved');
        require(keccak256(abi.encodePacked(organziationRefRevoked.dataUrlPropose)) == keccak256(abi.encodePacked(organziationRefChanged.dataUrlPropose)), 'Different identities');
        organziationRefChanged.status = StatusRegistration.BLOCKED;
        emit RegistrationRevoked(msg.sender);
        emit RegistrationApproved(_newOrganizationAddress);
    }
    
}


contract HelpRequestFundraisings is HelpRequestOrganizations {
    
    enum StatusProposal {PROPOSED, REVOKED, REFUSED, APPROVED}
    
    struct FundraisingProposal {
        string line;
        address organization;
        uint256 softcap;
        uint256 hardcap;
        address currency;
        uint256 timeout;
		address destination;
        StatusProposal proposalStatus;
        string metadata;
    }
    
    struct FundraisingApproved {
        address organization;
        uint256 softcap;
        uint256 hardcap;
        uint256 amountDonated;
        uint256 reservePercentage;
        uint256 serviceLinePercentage;
        uint256 allLinesPercentage;
        uint256 teamPercentage;
        address currency;
        uint256 deadline;
		address destination;
        bool isFunded;
        string metadata;
    }
    
    event FundraisingSubmittedLog(uint256 indexed _fundraisingId, string indexed _line, address indexed _organization,  uint256 _softcap, uint256 _hardcap, address _currency, uint256 _timeout, address _destination, string _metadata);
    
    event FundraisingRevokedLog(uint256 indexed _fundraisingId);
    
    event FundraisingRefusedLog(uint256 indexed _fundraisingId);
    
    event FundraisingApprovedLog(uint256 indexed _fundraisingId);
    
    event FundraisingCreatedLog(uint256 indexed _line, uint256 indexed _fundraisingId, address indexed _organization,  uint256 _softcap, uint256 _hardcap, uint256 _reserveSplit, uint256 _serviceLineSplit, uint256 _allLinesSplit, uint256 _teamSplit, address _currency, uint256 _timeout, address _destination, string _metadata);
    
    
    FundraisingProposal[] public proposals;
    
	
	constructor(WfcManagment _wfcManagment) public HelpRequestOrganizations(_wfcManagment) {
	}
    
    
    function SubmitFundraising(string calldata _line, uint256 _softcap, uint256 _hardcap, address _tokenAddress, uint256 _timeout, address _destination, string calldata _dataUrl) external {
        require(organizations[msg.sender].status == StatusRegistration.APPROVED, 'Organization not registred');
        require(wfcManagment.serviceLines(_line) == true, 'Wrong service Line');
        require(wfcManagment.tokenAddress(_tokenAddress) == true, 'Wrong token');
        require(_destination != address(0), 'Destination address must be different from zero address');
        uint256 propNumber = proposals.push(FundraisingProposal(_line, msg.sender, _softcap, _hardcap, _tokenAddress, _timeout, _destination, StatusProposal.PROPOSED, _dataUrl));
        emit FundraisingSubmittedLog(propNumber - 1, _line, msg.sender, _softcap, _hardcap, _tokenAddress, _timeout, _destination, _dataUrl);
    }
    
    function RevokeFundraising(uint256 _fundraisingId) external {
        FundraisingProposal storage proposal = proposals[_fundraisingId];
        require(msg.sender == proposal.organization, 'Wrong organization');
        require(proposal.proposalStatus == StatusProposal.PROPOSED, 'Wrong status of proposal');
        proposal.proposalStatus = StatusProposal.REVOKED;
        emit FundraisingRevokedLog(_fundraisingId);
    }
    
    function RefuseFundraising(uint256 _fundraisingId) external onlyOwnerDao() {
        FundraisingProposal storage proposal = proposals[_fundraisingId];
        require(proposal.proposalStatus == StatusProposal.PROPOSED, 'Wrong status of proposal');
        proposal.proposalStatus = StatusProposal.REFUSED;
        emit FundraisingRefusedLog(_fundraisingId);
    }
    
    function ApproveFundraising(uint256 _fundraisingId) external onlyOwnerDao() {
        FundraisingProposal storage proposal = proposals[_fundraisingId];
        require(proposal.proposalStatus == StatusProposal.PROPOSED, 'Wrong status of proposal');
        proposal.proposalStatus = StatusProposal.APPROVED;
        emit FundraisingApprovedLog(_fundraisingId);
        WfcDonations wfcDonations = WfcDonations(wfcManagment.donationContract());
        wfcDonations.createFundraising(proposal.line, proposal.organization, proposal.softcap, proposal.hardcap, proposal.currency, proposal.timeout, proposal.destination, proposal.metadata);
    }
	
}
