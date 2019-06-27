pragma solidity ^0.5.6;

import "ds-test/test.sol";
import "ds-math/math.sol";

import "./CedrusToken.sol";

contract Bob {
    CedrusToken token;

    constructor(CedrusToken token_) public {
        token = token_;
    }

    function mintCedarCoin(address claimAddress, uint256 cedarAmount) public {
        token.mintCedarCoin(claimAddress, cedarAmount);
    }

}

contract CedrusTokenTest is DSTest, DSMath {
    CedrusToken token;
    Bob bob;

    uint constant WAD = 10 ** 18;

    function setUp() public {
        token = new CedrusToken("CEDAR2019");
        bob = new Bob(token);
    }

    function test_mintCedarCoin() public {
        uint256 mintLimit = 1000;
        uint256 claimAmount = 10;
        address claimer = address(1234);
        
        token.updateMinter(address(bob), mintLimit);
        bob.mintCedarCoin(claimer, claimAmount);
    }

    function testFail_minterNotApproved() public {
        uint256 claimAmount = 10;
        address claimer = address(1234);
        
        bob.mintCedarCoin(claimer, claimAmount);
    }

    function testFail_minterLimitInvalid() public {
        uint256 mintLimit = 1;
        uint256 claimAmount = 10;
        address claimer = address(1234);
        
        token.updateMinter(address(bob), mintLimit);
        bob.mintCedarCoin(claimer, claimAmount);
        assertEq(token.balanceOf(address(bob)), mul(claimAmount, WAD));
    }

}
