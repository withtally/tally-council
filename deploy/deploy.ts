import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import fs from "fs";

const deployContracts: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments;
  const [deployerSigner] = await hre.ethers.getSigners();
  const deployer = await deployerSigner.getAddress();

  console.log("\x1B[37mDeploying ERC20Token contract");

  // Deploy ERC20Token contract
  await (async function deployERC20Token() {

    const erc20token = await deploy("ERC20Token", {
      from: deployer,
      log: true,
    });

    const erc20tokenBlock = await hre.ethers.provider.getBlock("latest");

    console.log(`\nERC20Token contract deployed at: `, erc20token.address);

    // Save to contracts.out file
    const erc20tokenDeployStr = `ERC20Token contract deployed at: ${erc20token.address} - Block number: ${erc20tokenBlock?.number}\n`;
    fs.appendFileSync("contracts.out", erc20tokenDeployStr);

    // Verify ERC20Token contract
    const erc20tokenVerifyStr = `npx hardhat verify --network ${hre.network.name} ${erc20token.address}\n`;
    console.log(erc20tokenVerifyStr);
    fs.appendFileSync("contracts.out", erc20tokenVerifyStr);
  })();

};

deployContracts.id = "erc20_token";
deployContracts.tags = ["ERC20Token"];

export default deployContracts;