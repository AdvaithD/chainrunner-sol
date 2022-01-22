pragma solidity ^0.8.5;
pragma experimental ABIEncoderV2;

contract Chainrunner {

    address owner;

    constructor() public {
		owner = msg.sender;
    }

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	function setOwner(address _o) onlyOwner external {
		owner = _o;
	}


    function GetMetaData(   
            address[] memory route
    ) external view returns (
        bytes32[] memory MetaData
    ){
        MetaData = new bytes32[](route.length * 8);
        assembly {
            
            let output := mload(0x40)
            let Routelen := mload(route)
            let data := add(route, 0x20)
            let _MetaData := add(MetaData,0x20)
            for
                {let end := add(data, mul(Routelen, 0x20)) }
                lt(data, end)
                {data := add(data, 0x20) }
            {
                let Lp := mload(data)
                mstore(_MetaData,Lp)

                // Token A
                mstore(add(_MetaData,0x20),Lp)
                // 	token0() 4byte (0x0dfe1681)
                mstore(output, 0x0dfe168100000000000000000000000000000000000000000000000000000000)
                if eq(staticcall(gas(),
                    Lp,
                    output,
                    0x4,
                    output,
                    0x20),1){
                       mstore(add(_MetaData,0x20), mload(output)) 
                    }


                // Decimal A
                mstore(add(_MetaData,0x40),Lp)
                // decimals 4byte (0x313ce567)
                mstore(output, 0x313ce56700000000000000000000000000000000000000000000000000000000)
                if eq(staticcall(gas(),
                    mload(add(_MetaData,0x20)),
                    output,
                    0x4,
                    output,
                    0x20),1){
                        mstore(add(_MetaData,0x40),mload(output))
                    }


                // Token B
                mstore(add(_MetaData,0x60),Lp)
                // .token1() 4byte (0xd21220a7)
                mstore(output, 0xd21220a700000000000000000000000000000000000000000000000000000000)
                if eq(staticcall(gas(),
                    Lp,
                    output,
                    0x4,
                    output,
                    0x20),1){
                        mstore(add(_MetaData,0x60),mload(output))
                    }

                // Decimal B
                mstore(add(_MetaData,0x80),Lp)
                // decimals 4byte (0x313ce567)
                mstore(output, 0x313ce56700000000000000000000000000000000000000000000000000000000)
                if eq(staticcall(gas(),
                    mload(add(_MetaData,0x60)),
                    output,
                    0x4,
                    output,
                    0x20),1){
                        mstore(add(_MetaData,0x80),mload(output))
                    }

                // Reserve 0 Reserve 1
                mstore(add(_MetaData,0xA4),Lp)
                mstore(add(_MetaData,0xC4),Lp)
                // get reserves 4byte (0x0902f1ac)
                mstore(output,0x0902f1ac00000000000000000000000000000000000000000000000000000000)
                if eq(staticcall(gas(),
                    Lp,
                    output, 
                    0x4,
                    output,
                    0x40),1){
                        mstore(add(_MetaData,0xA4), mload(output))
                        mstore(add(_MetaData,0xC4), mload(add(output, 0x20)))
                    }
                _MetaData := add(_MetaData,0x100)
            }
        }
    }



    function getAmountOutV4(
                                uint amountIn, 
                                bytes32[] memory MetaDataEncrypted, 
                                uint8 VerifyFlag
                            ) public view returns (bytes32[] memory Out) {

        Out = new bytes32[](MetaDataEncrypted.length);
        assembly {
            function revertWithReason(m, len) {
                        mstore(0, 0x08c379a000000000000000000000000000000000000000000000000000000000)
                        mstore(0x20, 0x0000002000000000000000000000000000000000000000000000000000000000)
                        mstore(0x40, m)
                        revert(0, len)
                }

            
            let emptyPtr := mload(0x40)
            let _res_ptr := add(Out, 0x20)

            let data := add(MetaDataEncrypted, 0x40)
            let AmountOut := amountIn
            
            for {let end := add(sub(data,0x20), mul(mload(MetaDataEncrypted), 0x20))}
                    lt(data, end)
                    {data := add(data, 0x40) }
            {
                // Get Trading Fee & Flag
                let fee := shr(236,and(mload(data),0x0ffff00000000000000000000000000000000000000000000000000000000000))
                mstore(emptyPtr,0x0902f1ac00000000000000000000000000000000000000000000000000000000)
                if iszero(staticcall(gas(),
                    // code - "chainrunner"
                    and(sub(mload(data), "chainrunner"), 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff),
                    emptyPtr, 
                    0x4,
                    emptyPtr,
                    0x40)){
                        returndatacopy(0, 0, returndatasize())
                        revert(0, returndatasize())
                    }

                switch eq(and(mload(data),0xf000000000000000000000000000000000000000000000000000000000000000),0x0000000000000000000000000000000000000000000000000000000000000000)
                case true {
                    AmountOut := div(mul(mload(add(emptyPtr, 0x20)),mul(AmountOut,fee)),add(mul(AmountOut,fee),mul(mload(emptyPtr),10000)))
                }
                default {
                    AmountOut := div(mul(mload(emptyPtr),mul(AmountOut,fee)),add(mul(AmountOut,fee),mul(mload(add(emptyPtr, 0x20)),10000)))
                }
                mstore(_res_ptr, mload(emptyPtr)) 
                mstore(add(_res_ptr,0x20), mload(add(emptyPtr, 0x20)))
                _res_ptr := add(_res_ptr,0x40)
                
            }
            if eq(VerifyFlag, 1){
                if lt(AmountOut,amountIn)
                {
                    revertWithReason(0x000000164d696e2072657475726e206e6f742072656163686564000000000000, 0x5a)
                }
            } 
            mstore(_res_ptr, AmountOut) 
        } 
    }

    
    function _swapSupportingFeesV4(
        uint256 AmountIn,
        bytes32[] memory MetaDataEncrypted,
        uint8 Chi, uint8 VerifyFlag
    ) onlyOwner external payable returns (uint AmountOut, uint GasUsed){ 

       
       (bytes32[] memory _res) = getAmountOutV4(AmountIn,MetaDataEncrypted,VerifyFlag);
       //Out = new bytes32[](MetaDataEncrypted.length);
       
       
        assembly {
            function revertWithReason(m, len) {
                mstore(0, 0x08c379a000000000000000000000000000000000000000000000000000000000)
                mstore(0x20, 0x0000002000000000000000000000000000000000000000000000000000000000)
                mstore(0x40, m)
                revert(0, len)
            }

            /// Start here 
            let emptyPtr := mload(0x40)
            AmountOut := AmountIn

            // reserves data 
            let _res_ptr := add(_res, 0x20)
            // code - string
            let TokenOut := sub(mload(add(MetaDataEncrypted, 0x20)), "chainrunner") // Initial Token In
            let data := add(MetaDataEncrypted, 0x40)
            let Lp := and(sub(mload(data), "chainrunner"), 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff)

            // First do a transfer to the pair 
            mstore(emptyPtr, 0x23b872dd00000000000000000000000000000000000000000000000000000000)
            mstore(add(emptyPtr, 0x4), caller())
            mstore(add(emptyPtr, 0x24), Lp)
            mstore(add(emptyPtr, 0x44), AmountIn)
            if iszero(call(gas(), TokenOut, 0, emptyPtr, 0x64, 0, 0)) {
                revert(0, returndatasize())
            }

            let _err_msg := 0x00000011696e76616c6964203000000000000000000000000000000000000000

        
            for {let end := add(sub(data,0x20), mul(mload(MetaDataEncrypted), 0x20))}
                    lt(data, end)
                    {data := add(data, 0x40) }
            {
                let fee := shr(236,and(mload(data),0x0ffff00000000000000000000000000000000000000000000000000000000000))
                Lp := and(sub(mload(data), "chainrunner"), 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff)

                // Get the balance of the TokenA of the target Lp
                mstore(emptyPtr,0x70a0823100000000000000000000000000000000000000000000000000000000)
                mstore(add(emptyPtr, 0x04), Lp)
                if iszero(staticcall(gas(),
                    TokenOut,
                    emptyPtr,
                    0x24,
                    emptyPtr,
                    0x20)){
                        returndatacopy(0, 0, returndatasize())
                        revert(0, returndatasize())
                    }

                TokenOut := sub(mload(add(data, 0x20)),"chainrunner")
                switch eq(and(mload(data),0xf000000000000000000000000000000000000000000000000000000000000000),0x0000000000000000000000000000000000000000000000000000000000000000)
                case true {
                    AmountOut := mul(sub(mload(emptyPtr) ,mload(_res_ptr)),fee)
                    AmountOut := div(mul(AmountOut, mload(add(_res_ptr,0x20))), add(AmountOut, mul( mload(_res_ptr), 10000)))
                    mstore(emptyPtr, 0x022c0d9f00000000000000000000000000000000000000000000000000000000)
                    mstore(add(emptyPtr, 0x04), 0)
                    mstore(add(emptyPtr, 0x24), AmountOut)
                }
                default {

                    AmountOut := mul(sub(mload(emptyPtr) ,mload(add(_res_ptr,0x20))),fee)
                    AmountOut := div(mul(AmountOut,  mload(_res_ptr)), add(AmountOut, mul(mload(add(_res_ptr,0x20)), 10000)))

                    mstore(emptyPtr, 0x022c0d9f00000000000000000000000000000000000000000000000000000000) 
                    mstore(add(emptyPtr, 0x04), AmountOut)
                    mstore(add(emptyPtr, 0x24), 0)
                }
                
            
                switch lt(data,sub(end,0x40))
                case true{
                    mstore(add(emptyPtr, 0x44), and(sub(mload(add(data,0x40)),"chainrunner"), 0x000000000000000000000000ffffffffffffffffffffffffffffffffffffffff)) 
                    mstore(add(emptyPtr, 0x64), 0x80)
                    mstore(add(emptyPtr, 0x84), 0)
                    if iszero(call(gas(), sub(mload(data),"chainrunner"), 0, emptyPtr, 0xa4, 0, 0)) {
                        revertWithReason(_err_msg, 0x55)

                    }
                } 
                case false {
                    if eq(VerifyFlag, 1){
                        if lt(AmountOut,AmountIn)
                        {
                            revertWithReason(0x000000164d696e2072657475726e206e6f742072656163686564000000000000, 0x5a)
                        }
                    } 
                    mstore(add(emptyPtr, 0x44), caller())
                    mstore(add(emptyPtr, 0x64), 0x80)
                    mstore(add(emptyPtr, 0x84), 0)
                    if iszero(call(gas(), Lp, 0, emptyPtr, 0xa4, 0, 0)) {
                        revertWithReason(_err_msg, 0x55)
                    }
                }
                _res_ptr := add(_res_ptr, 0x40) 
                _err_msg := add(_err_msg,0x0000000000000000000000000100000000000000000000000000000000000000)
            }
            if gt(Chi,0){
                mstore(emptyPtr, 0xd8ccd0f300000000000000000000000000000000000000000000000000000000)
                mstore(add(emptyPtr, 0x04), Chi) 
                if iszero(call(gas(), 0x0000000000004946c0e9F43F4Dee607b0eF1fA1c, 0, emptyPtr, 0x44, 0, 0)) {
                    returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
                }
            }
            GasUsed := gas()
            
        }
    }



    fallback() external payable {}

    receive() external payable {}

}


