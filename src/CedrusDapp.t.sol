pragma solidity ^0.5.6;

import "ds-test/test.sol";

import "./CedrusDapp.sol";

contract CedrusDappTest is DSTest {
    CedrusDapp dapp;

    function setUp() public {
        dapp = new CedrusDapp();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
