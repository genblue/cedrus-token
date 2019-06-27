pragma solidity ^0.5.6;

import "ds-token/token.sol";

contract CedrusToken is DSToken {

    // Store minting limits for addresses 
    mapping (address => uint256) minters;

    constructor(bytes32 symbol_) public DSToken(symbol_) {}

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
        // token uses wad number type to store user balances
        this.mint(claimAddress, mul(cedarAmount, WAD));
    }
}
