// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingPool {
    uint public rewardPercentage;
    uint public rewardInterval;
    uint public totalStaked;
    address public token;
    mapping (address => Stake) public stakes;

    error TransferFailed();
    error NoStake();
    error AlreadyStaked();
    error RewardIntervalNotReached();

    event BeginStake(address indexed staker, uint amount);
    event EndStake(address indexed staker, uint amount, uint reward);

    struct Stake {
        uint amount;
        uint datetime;
    }

    constructor (uint _rewardPercentage, uint _rewardInterval, address _token) {
        rewardPercentage = _rewardPercentage;
        rewardInterval = _rewardInterval;
        token = _token;
    }

    function stake (uint _amount) external {
        if (_amount == 0) {
            revert NoStake();
        }
        if (stakes[msg.sender].amount > 0) {
            revert AlreadyStaked();
        }
        IERC20(token).transferFrom(msg.sender, address(this), _amount);
        totalStaked += _amount;
        stakes[msg.sender].amount = _amount;
        stakes[msg.sender].datetime = block.timestamp;

        emit BeginStake(msg.sender, _amount);
    }

    function unstake () external {
        uint amount = stakes[msg.sender].amount;
        if (amount == 0) {
            revert NoStake();
        }
        if (block.timestamp - stakes[msg.sender].datetime < rewardInterval) {
            revert RewardIntervalNotReached();
        }
        uint reward = (amount * rewardPercentage) / 100;
        totalStaked -= amount;
        stakes[msg.sender].amount = 0;
        IERC20(token).transfer(msg.sender, amount + reward);
        emit EndStake(msg.sender, amount, reward);
    }
}
