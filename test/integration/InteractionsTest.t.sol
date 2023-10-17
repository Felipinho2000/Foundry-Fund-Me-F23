// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployFundMe} from "script/DeployFundMe.s.sol";
import {FundMe} from "src/FundMe.sol";
import {Test} from "forge-std/Test.sol";
import {FundFundMe, WithdrawFundMe} from "script/Interactions.s.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract IntegrationsTest is StdCheats, Test {
    FundMe public fundMe;
    HelperConfig public helperConfig;

    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_USER_BALANCE = 1 ether;
    uint256 constant GAS_PRICE = 1;

    address public constant USER = address(1);
    
    function setUp() external {
        DeployFundMe deployer = new DeployFundMe();
        (fundMe, helperConfig) = deployer.run();
        vm.deal(USER, STARTING_USER_BALANCE);
    }

     function testUserCanFundAndOwnerWithdraw() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
    
}