pragma solidity ^0.5.6;

import "ds-test/test.sol";

import "./CedrusToken.sol";

contract CedrusTokenTest is DSTest {
    CedrusToken token;

    function setUp() public {
        token = new CedrusToken();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
