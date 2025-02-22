// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { Token } from "../src/Token.sol";
import {PoolCreator} from "../src/PoolCreator.sol";

contract PoolCreatorTest is Test {
    Token public token;
    PoolCreator public poolCreator;

    function setUp() public {
        token = new Token();
        poolCreator = new PoolCreator();
    }

    function test_PoolCreation() public {
        poolCreator.createPool(5, 60, address(token));
        assertEq(poolCreator.poolCount(), 1);
    }
}
