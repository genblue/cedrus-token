pragma solidity ^0.5.6;

import "ds-auth/auth.sol";
import "ds-token/token.sol";
import "ds-math/math.sol";

contract CedrusToken is DSAuth {

    // token
    // cedar token to mint
    DSToken token;

    mapping (address => uint256) minters;

    constructor() public {
        token = new DSToken("CEDAR2019");
    }

    modifier isMinterApproved(address minter_, uint256 mintingamount) {
        require(minters[msg.sender] >= mintingamount, 'insufficient mint limit');
        _;
    }

    function updateMinter(address minter_, uint256 newlimit_) public auth {
        minters[minter_] = newlimit_;
    }

    function mintCedarCoin(address claimAddress, uint256 cedarAmount) 
        public 
        isMinterApproved(msg.sender, cedarAmount) 
    {
        // subtract minting amount from minter's limitnot
        token.mint(claimAddress, cedarAmount);
    }
}
