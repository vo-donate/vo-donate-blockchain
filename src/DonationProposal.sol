// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MemberRegistry.sol";

contract DonationProposal {
    address public proposer;
    string public proposalText;
    uint256 public totalDonation;
    uint256 public voteCount;
    uint256 public voterCount;
    uint256 public endTime;
    uint256 public donationEndTime;
    bool public votePassed;
    bool public finalized;
    bool public withdrawn;

    uint256 public constant STAKE_AMOUNT = 1000 wei;

    MemberRegistry public registry;

    mapping(address => uint256) public donations;
    mapping(address => bool) public hasVoted;
    address[] public donors;
    address[] public voters;

    constructor(address _proposer, string memory _text, address _registry, uint256 _voteDurationMinutes, uint256 _donationDurationMinutes) {
        proposer = _proposer;
        proposalText = _text;
        registry = MemberRegistry(_registry);
        endTime = block.timestamp + (_voteDurationMinutes * 1 minutes);
        donationEndTime = endTime + (_donationDurationMinutes * 1 minutes);
    }

    modifier onlyDuringVoting() {
        require(block.timestamp < endTime, "Voting ended");
        _;
    }

    modifier onlyAfterVoting() {
        require(block.timestamp >= endTime, "Voting still ongoing");
        _;
    }

    function vote(bool approve) external payable onlyDuringVoting {
        require(msg.value == STAKE_AMOUNT, "Must stake exact 1000 wei");
        require(!hasVoted[msg.sender], "Already voted");
        require(registry.isMember(msg.sender), "Not a member");

        voters.push(msg.sender);
        hasVoted[msg.sender] = true;
        voterCount++;
        if (approve) voteCount++;
    }

    function finalizeVote() external onlyAfterVoting {
        require(!finalized, "Already finalized");
        finalized = true;

        if (voteCount * 3 >= registry.getMemberCount() * 2) {
            votePassed = true;
            for (uint256 i = 0; i < voters.length; i++) {
                payable(voters[i]).transfer(STAKE_AMOUNT);
            }
        } else {
            for (uint256 i = 0; i < voters.length; i++) {
                payable(voters[i]).transfer(STAKE_AMOUNT);
            }

            for (uint256 i = 0; i < donors.length; i++) {
                address donor = donors[i];
                payable(donor).transfer(donations[donor]);
                donations[donor] = 0;
            }
        }
    }

    function donate() external payable {
        require(finalized && votePassed, "Proposal not passed");
        require(block.timestamp <= donationEndTime, "Donation period ended");
        if (donations[msg.sender] == 0) donors.push(msg.sender);
        donations[msg.sender] += msg.value;
        totalDonation += msg.value;
    }

    function withdraw() external {
        require(msg.sender == proposer, "Only proposer");
        require(finalized && votePassed, "Not allowed");
        require(!withdrawn, "Already withdrawn");
        require(block.timestamp > donationEndTime, "Donation time not ended");
        withdrawn = true;
        payable(proposer).transfer(address(this).balance);
    }

    function getSummary()
        public
        view
        returns (address, string memory, uint256, bool, uint256, uint256, uint256, bool, uint256)
    {
        return (
            proposer,
            proposalText,
            totalDonation,
            finalized,
            voteCount,
            voterCount,
            address(this).balance,
            votePassed,
            donationEndTime
        );
    }
}
