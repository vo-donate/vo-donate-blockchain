// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DonationProposal.sol";
import "./MemberRegistry.sol";

contract DonationProposalFactory {
    address public registryAddress;
    address[] public deployedProposals;

    event ProposalCreated(address proposalAddress, address proposer, string text, uint256 voteDeadline, uint256 donationDeadline);

    constructor(address _registryAddress) {
        registryAddress = _registryAddress;
    }

    function createProposal(string memory _text, uint256 voteDurationInMinutes, uint256 donationDurationInMinutes) external {
        DonationProposal proposal = new DonationProposal(msg.sender, _text, registryAddress, voteDurationInMinutes, donationDurationInMinutes);
        deployedProposals.push(address(proposal));
        emit ProposalCreated(
            address(proposal), msg.sender, _text, block.timestamp + (voteDurationInMinutes * 1 minutes), block.timestamp + (voteDurationInMinutes * 1 minutes) + (donationDurationInMinutes * 1 minutes)
        );
    }

    function getProposals() external view returns (address[] memory) {
        return deployedProposals;
    }
}
