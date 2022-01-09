
pragma solidity ^0.8.5;
pragma experimental ABIEncoderV2;

contract ArbV1 {

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
}