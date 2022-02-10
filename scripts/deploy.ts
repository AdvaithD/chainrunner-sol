// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import * as fs from "fs";
import { ethers, waffle } from "hardhat";
import {
  NETWORK_MAP,
} from "./constants";

async function main() {
  const chainId = (await waffle.provider.getNetwork()).chainId;
  const networkName = NETWORK_MAP[chainId];
  const isLocal = networkName === "hardhat";

  console.log(`Deploying to ${networkName}`);

  const chainrunner = await ethers.getContractFactory("Chainrunner");
  const Chainrunner = await chainrunner.deploy();

  await Chainrunner.deployed();

  console.log("Chainrunner deployed to:", Chainrunner.address);
  const info = {
    Contracts: {
      Chainrunner: {
        chainId,
        network: networkName,
        address: Chainrunner.address,
        args: [],
        abi: JSON.parse(
          Chainrunner.interface.format(ethers.utils.FormatTypes.json) as string
        ),
      },
    },
  };

  console.log("** End Deployment **\n");

  console.log("** Contract Info **");
  console.log(info);

  if (!isLocal) {
    fs.writeFileSync(
      `${__dirname}/../../deployments/chainrunner/${networkName}.json`,
      JSON.stringify(info, null, 2)
    );
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
