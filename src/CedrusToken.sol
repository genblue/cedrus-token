pragma solidity ^0.5.6;

import "ds-auth/auth.sol";
import "ds-token/token.sol";
import "ds-math/math.sol";

contract CedrusToken is DSAuth, DSMath {

    // Cedar token
    DSToken token;

    // Store minting limits for addresses 
    mapping (address => uint256) minters;

    constructor(bytes32 name_) public {
        token = new DSToken(name_);
    }

    modifier isMintingValid(address minter_, uint256 mintingamount) {
        uint256 currentLimit = minters[minter_];

        // Checks whether the minter is approved for their minting amonut
        require(currentLimit >= mintingamount, 'insufficient mint limit');

        // Reduce current limit of minter by the minting amount
        minters[minter_] = sub(currentLimit, mintingamount);
        _;
    }

    // Allows the token owner to set minting limits
    function updateMinter(address minter_, uint256 newlimit_) public auth {
        minters[minter_] = newlimit_;
    }

    // Allows an approved minter to mint new Cedar Coins for an address after
    // validating their donations off-chain
    function mintCedarCoin(address claimAddress, uint256 cedarAmount) 
        public 
        isMintingValid(msg.sender, cedarAmount) 
    {
        token.mint(claimAddress, cedarAmount);
    }
}
