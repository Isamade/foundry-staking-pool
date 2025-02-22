// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { Token } from "../src/Token.sol";
import {PoolCreator} from "../src/PoolCreator.sol";
import { StakingPool } from "../src/StakingPool.sol";

contract StakingPoolTest is Test {
    Token public token;
    StakingPool public stakingPool;

    function setUp() public {
        address deployer = vm.addr(1);
        vm.prank(deployer);
        token = new Token();
        stakingPool = new StakingPool(5, 1, address(token));
    }

    function test_Staking() public {
        address deployer = vm.addr(1);
        vm.prank(deployer);
        token.approve(address(stakingPool), 100000);
        vm.prank(deployer);
        stakingPool.stake(100);
        assertNotEq(stakingPool.totalStaked(), 0);
    }

    function test_Unstaking() public {
        address deployer = vm.addr(1);
        vm.prank(deployer);
        token.approve(address(stakingPool), 100000);
        vm.prank(deployer);
        stakingPool.stake(1);
        vm.warp(block.timestamp + 5 seconds);
        vm.prank(deployer);
        stakingPool.unstake();
        assertEq(stakingPool.totalStaked(), 0);
    }
}