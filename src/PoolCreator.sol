// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { StakingPool } from "./StakingPool.sol";

contract PoolCreator is Ownable {
    uint public poolCount;
    mapping(uint => address) public pools;

    constructor() Ownable(msg.sender) {}

    function createPool(uint _rewardPercentage, uint _rewardInterval, address _token) public onlyOwner {
        address newPool = address(new StakingPool(_rewardPercentage, _rewardInterval, _token));
        pools[poolCount] = newPool;
        poolCount++;
    }
}