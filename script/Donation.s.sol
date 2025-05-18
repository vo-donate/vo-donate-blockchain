// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MemberRegistry} from "../src/MemberRegistry.sol";
import {DonationProposalFactory} from "../src/DonationProposalFactory.sol";

contract DeployScript is Script {
    MemberRegistry public registry;
    DonationProposalFactory public factory;

    function run() public {
        vm.startBroadcast();

        registry = new MemberRegistry();
        factory = new DonationProposalFactory(address(registry));

        console.log("Registry deployed at:", address(registry));
        console.log("Factory deployed at:", address(factory));

        vm.stopBroadcast();
    }
}
