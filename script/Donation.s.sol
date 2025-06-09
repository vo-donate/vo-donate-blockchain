// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MemberRegistry} from "../src/MemberRegistry.sol";

contract DeployScript is Script {
    MemberRegistry public registry;

    function setUp() public {}

function run() public {
    vm.startBroadcast();
    registry = new MemberRegistry();
    console.log("Wallet address:", msg.sender);
    console.log("Registry deployed at:", address(registry));
    vm.stopBroadcast();
}
}
