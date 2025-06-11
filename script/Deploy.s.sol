// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {MemberRegistry} from "../src/MemberRegistry.sol";
import {DonationProposalFactory} from "../src/DonationProposalFactory.sol";

contract DeployScript is Script {
    function run() public {
        vm.startBroadcast();
        MemberRegistry registry = new MemberRegistry();

        DonationProposalFactory factory = new DonationProposalFactory(address(registry));

        console.log("MemberRegistry deployed to:", address(registry));
        console.log("DonationProposalFactory deployed to:", address(factory));

        vm.stopBroadcast();
    }
}
