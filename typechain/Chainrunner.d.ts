/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import {
  ethers,
  EventFilter,
  Signer,
  BigNumber,
  BigNumberish,
  PopulatedTransaction,
  BaseContract,
  ContractTransaction,
  Overrides,
  PayableOverrides,
  CallOverrides,
} from "ethers";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";
import type { TypedEventFilter, TypedEvent, TypedListener } from "./common";

interface ChainrunnerInterface extends ethers.utils.Interface {
  functions: {
    "GetMetaData(address[])": FunctionFragment;
    "_swapSupportingFeesV4(uint256,bytes32[],uint8,uint8)": FunctionFragment;
    "getAmountOutV4(uint256,bytes32[],uint8)": FunctionFragment;
    "payout(bytes)": FunctionFragment;
    "setOwner(address)": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "GetMetaData",
    values: [string[]]
  ): string;
  encodeFunctionData(
    functionFragment: "_swapSupportingFeesV4",
    values: [BigNumberish, BytesLike[], BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getAmountOutV4",
    values: [BigNumberish, BytesLike[], BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "payout", values: [BytesLike]): string;
  encodeFunctionData(functionFragment: "setOwner", values: [string]): string;

  decodeFunctionResult(
    functionFragment: "GetMetaData",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "_swapSupportingFeesV4",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getAmountOutV4",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "payout", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "setOwner", data: BytesLike): Result;

  events: {};
}

export class Chainrunner extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  listeners<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter?: TypedEventFilter<EventArgsArray, EventArgsObject>
  ): Array<TypedListener<EventArgsArray, EventArgsObject>>;
  off<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  on<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  once<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  removeListener<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  removeAllListeners<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>
  ): this;

  listeners(eventName?: string): Array<Listener>;
  off(eventName: string, listener: Listener): this;
  on(eventName: string, listener: Listener): this;
  once(eventName: string, listener: Listener): this;
  removeListener(eventName: string, listener: Listener): this;
  removeAllListeners(eventName?: string): this;

  queryFilter<EventArgsArray extends Array<any>, EventArgsObject>(
    event: TypedEventFilter<EventArgsArray, EventArgsObject>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEvent<EventArgsArray & EventArgsObject>>>;

  interface: ChainrunnerInterface;

  functions: {
    GetMetaData(
      route: string[],
      overrides?: CallOverrides
    ): Promise<[string[]] & { MetaData: string[] }>;

    _swapSupportingFeesV4(
      AmountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      Chi: BigNumberish,
      VerifyFlag: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    getAmountOutV4(
      amountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      VerifyFlag: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[string[]] & { Out: string[] }>;

    payout(
      payouts: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    setOwner(
      _o: string,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;
  };

  GetMetaData(route: string[], overrides?: CallOverrides): Promise<string[]>;

  _swapSupportingFeesV4(
    AmountIn: BigNumberish,
    MetaDataEncrypted: BytesLike[],
    Chi: BigNumberish,
    VerifyFlag: BigNumberish,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  getAmountOutV4(
    amountIn: BigNumberish,
    MetaDataEncrypted: BytesLike[],
    VerifyFlag: BigNumberish,
    overrides?: CallOverrides
  ): Promise<string[]>;

  payout(
    payouts: BytesLike,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  setOwner(
    _o: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    GetMetaData(route: string[], overrides?: CallOverrides): Promise<string[]>;

    _swapSupportingFeesV4(
      AmountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      Chi: BigNumberish,
      VerifyFlag: BigNumberish,
      overrides?: CallOverrides
    ): Promise<
      [BigNumber, BigNumber] & { AmountOut: BigNumber; GasUsed: BigNumber }
    >;

    getAmountOutV4(
      amountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      VerifyFlag: BigNumberish,
      overrides?: CallOverrides
    ): Promise<string[]>;

    payout(payouts: BytesLike, overrides?: CallOverrides): Promise<void>;

    setOwner(_o: string, overrides?: CallOverrides): Promise<void>;
  };

  filters: {};

  estimateGas: {
    GetMetaData(route: string[], overrides?: CallOverrides): Promise<BigNumber>;

    _swapSupportingFeesV4(
      AmountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      Chi: BigNumberish,
      VerifyFlag: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    getAmountOutV4(
      amountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      VerifyFlag: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    payout(
      payouts: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    setOwner(
      _o: string,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    GetMetaData(
      route: string[],
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    _swapSupportingFeesV4(
      AmountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      Chi: BigNumberish,
      VerifyFlag: BigNumberish,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    getAmountOutV4(
      amountIn: BigNumberish,
      MetaDataEncrypted: BytesLike[],
      VerifyFlag: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    payout(
      payouts: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    setOwner(
      _o: string,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;
  };
}
