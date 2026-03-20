const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with account:", deployer.address);

  const Token = await hre.ethers.getContractFactory("GovernanceToken");
  const token = await Token.deploy(1000000); // 1 Million supply
  await token.waitForDeployment();
  console.log("Token deployed to:", await token.getAddress());

  const Voting = await hre.ethers.getContractFactory("SimpleVoting");
  const voting = await Voting.deploy(await token.getAddress());
  await voting.waitForDeployment();
  console.log("Voting contract deployed to:", await voting.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
