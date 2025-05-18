// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MemberRegistry.sol";
import "../src/DonationProposal.sol";
import "../src/DonationProposalFactory.sol";

contract DonationTest is Test {
    MemberRegistry registry;
    DonationProposalFactory factory;

    address deployer;
    address proposer;
    address[] users;

    function setUp() public {
        // 초기 지갑 10개 생성 및 10 ETH씩 할당
        for (uint i = 1; i <= 10; i++) {
            address wallet = vm.addr(i);
            vm.deal(wallet, 10 ether);
            users.push(wallet);
        }

        deployer = users[0];
        proposer = users[1];

        // deployer로 registry & factory 배포
        vm.startPrank(deployer);
        registry = new MemberRegistry();
        factory = new DonationProposalFactory(address(registry));
        vm.stopPrank();

        // proposer 포함 9명 멤버 등록
        for (uint i = 1; i < 10; i++) {
            vm.prank(deployer);
            registry.register(users[i]);
        }
    }

    function testProposalFlow() public {
        // proposer가 제안 생성
        vm.prank(proposer);
        factory.createProposal("Scholarship Donation", 2);

        // 제안 주소 확인
        address[] memory proposals = factory.getProposals();
        DonationProposal proposal = DonationProposal(proposals[0]);

        // 찬성 6명 투표
        for (uint i = 2; i < 8; i++) {
            vm.prank(users[i]);
            proposal.vote{value: 1000 wei}(true);
        }

        // 반대 2명 투표
        for (uint i = 8; i < 10; i++) {
            vm.prank(users[i]);
            proposal.vote{value: 1000 wei}(false);
        }

        // 시간 경과 (1시간 이후로 이동)
        skip(1 hours);
        skip(1 seconds);

        // finalize
        vm.prank(proposer);
        proposal.finalizeVote();

        assertTrue(proposal.votePassed(), "donation fail");

        // 6명 기부 (1 ETH씩)
        for (uint i = 2; i < 8; i++) {
            vm.prank(users[i]);
            proposal.donate{value: 1 ether}();
        }

        // 시간 경과 (기부 마감 이후로 이동)
        skip(2 minutes);

        // withdraw 전 proposer 잔액
        uint before = proposer.balance;

        // proposer가 withdraw
        vm.prank(proposer);
        proposal.withdraw();

        uint afterBalance = proposer.balance;

        // 6 ETH 만큼 증가했는지 확인
        assertEq(afterBalance - before, 6 ether, "donation withdraw fail");
    }
}