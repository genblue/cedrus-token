pragma solidity ^0.5.6;

import "ds-auth/auth.sol";
import "ds-token/token.sol";

contract CedrusToken is DSAuth {

    // token
    // cedar token to mint
    DSToken token;

    // mintcode
    // mapping string value mintcode (bytes32) to an expiration date (unit256)
    mapping (bytes32 => uint256) mintcodes;

    constructor() public {
        token = new DSToken("CEDAR2019");
    }

    // generateMintCode
    // creates a new mintcode with default expiration date
    function generateMintCode() public auth {

    }

    // disableMintCode
    // disables and existing mintcode if it exists
    function disableMintCode() public auth {

    }

    // mintCedarCoin
    // tbd
    function mintCedarCoin(bytes32 secret, uint256 cedarAmount) public {
        bytes32 mintcode = keccak256(abi.encodePacked(secret, cedarAmount));

        // check that mintcode has not expired
        require(mintcodes[mintcode] < now, 'mintcode invalid');

        // tbd. now mint new cedar token(s) and transfer to msg.sender
    }
}
