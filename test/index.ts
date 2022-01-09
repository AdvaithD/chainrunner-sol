import { expect } from "chai";
import { ethers } from "hardhat";
import { ArbV1 } from "../typechain";

describe("ArbV1", function () {
  it("should get metadata", async function () {
    const Arber = await ethers.getContractFactory("ArbV1");
    const arber: ArbV1 = await Arber.deploy();
    await arber.deployed();

    // expect(await greeter.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // create path [WETH -> WBTC -> SUSHI -> WETH]
    const path = [
      "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
      "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599",
      "0x6b3595068778dd592e39a122f4f5a5cf09c90fe2",
      "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
    ];

    // // wait until the transaction is mined
    // await setGreetingTx.wait();
    const data = await arber.callStatic.GetMetaData(path);

    console.log("data:", data);

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
