# Simple ERC20 Governance Toolkit 🏛️

This repository provides a streamlined, expert-level implementation of a Decentralized Autonomous Organization (DAO) voting system. It utilizes the ERC20 standard to represent voting power, allowing token holders to create and vote on proposals.

## Features
- **Governance Token**: A standard ERC20 token used to measure voting weight.
- **Proposal Lifecycle**: Create proposals with specific descriptions and track "For" or "Against" votes.
- **Security**: Built-in checks to ensure only token holders can participate.
- **Flat Structure**: All contracts are in the root directory for easy auditing and deployment.

## Technical Stack
- Solidity ^0.8.20
- OpenZeppelin Contracts
- Hardhat / Foundry compatible

## Usage
1. Deploy `GovernanceToken.sol`.
2. Deploy `SimpleVoting.sol` using the token address from step 1.
3. Users with tokens can now call `vote()` on active proposals.
