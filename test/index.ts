import { expect } from "chai";
import { ethers } from "hardhat";

describe("ArbV1", function () {
  it("should get metadata", async function () {
    const Arber = await ethers.getContractFactory("ArbV1");
    const arber = await Arber.deploy();
    await arber.deployed();

    // expect(await greeter.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
