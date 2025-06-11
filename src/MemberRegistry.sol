// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MemberRegistry {
    mapping(address => bool) public isMember;
    address[] public member;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function register(address _user) external onlyOwner {
        if (!isMember[_user]) {
            isMember[_user] = true;
            member.push(_user);
        }
    }

    function unregister(address _user) external onlyOwner {
        require(isMember[_user], "User not a member");
        isMember[_user] = false;

        for (uint256 i = 0; i < member.length; i++) {
            if (member[i] == _user) {
                member[i] = member[member.length - 1];
                member.pop();
                break;
            }
        }
    }

    function getAllMembers() external view returns (address[] memory) {
        return member;
    }

    function getMemberCount() external view returns (uint256) {
        return member.length;
    }
}
