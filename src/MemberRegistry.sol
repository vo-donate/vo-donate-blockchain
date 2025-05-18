// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MemberRegistry {
    mapping(address => bool) public isMember;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function register(address _user) external onlyOwner {
        isMember[_user] = true;
    }

    function unregister(address _user) external onlyOwner {
        isMember[_user] = false;
    }
}
