import { expect } from "chai";
import { ethers } from "hardhat";

// @dev - deploy chainrunner contract
const deployChainrunner = async () => {
  const factory = await ethers.getContractFactory("Chainrunner");
  const chainrunner = await factory.deploy();
  await chainrunner.deployed();

  return chainrunner;
};

describe("Chainrunner::init", function () {
  let deployer: any;
  let chainrunner: any;

  before(async () => {
    [deployer] = await ethers.getSigners();
  });

  beforeEach(async () => {
    chainrunner = await deployChainrunner();
  });

  it("should get metadata", async function () {
    // create path [WETH -> WBTC -> SUSHI -> WETH]
    const path = [
      "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
      "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599",
      "0x6b3595068778dd592e39a122f4f5a5cf09c90fe2",
      "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
    ];

    // // wait until the transaction is mined
    // await setGreetingTx.wait();
    const data = await chainrunner.callStatic.GetMetaData(path);

    console.log("data:", data);

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
