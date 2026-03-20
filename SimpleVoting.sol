// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GovernanceToken.sol";

contract SimpleVoting {
    GovernanceToken public votingToken;

    struct Proposal {
        string description;
        uint256 voteCountFor;
        uint256 voteCountAgainst;
        bool executed;
        mapping(address => bool) hasVoted;
    }

    Proposal[] public proposals;

    event ProposalCreated(uint256 indexed id, string description);
    event VoteCast(address indexed voter, uint256 indexed proposalId, bool support);

    constructor(address _tokenAddress) {
        votingToken = GovernanceToken(_tokenAddress);
    }

    function createProposal(string calldata _description) external {
        require(votingToken.balanceOf(msg.sender) > 0, "Must hold tokens to propose");
        
        Proposal storage newProposal = proposals.push();
        newProposal.description = _description;
        
        emit ProposalCreated(proposals.length - 1, _description);
    }

    function vote(uint256 _proposalId, bool _support) external {
        require(_proposalId < proposals.length, "Invalid proposal");
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.hasVoted[msg.sender], "Already voted");

        uint256 weight = votingToken.balanceOf(msg.sender);
        require(weight > 0, "No voting power");

        if (_support) {
            proposal.voteCountFor += weight;
        } else {
            proposal.voteCountAgainst += weight;
        }

        proposal.hasVoted[msg.sender] = true;
        emit VoteCast(msg.sender, _proposalId, _support);
    }

    function getProposalCount() external view returns (uint256) {
        return proposals.length;
    }
}
