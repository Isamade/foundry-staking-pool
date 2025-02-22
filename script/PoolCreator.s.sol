// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PoolCreator} from "../src/PoolCreator.sol";

contract PoolCreatorScript is Script {
    PoolCreator public poolCreator;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        poolCreator = new PoolCreator();

        vm.stopBroadcast();
    }
}
