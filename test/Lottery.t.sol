// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lottery.sol";

contract LotteryTest is Test {
    Lottery public lottery;
    uint256 received_msg_value;
    function setUp() public {
       lottery = new Lottery(); //new -> contract 배포
       received_msg_value = 0;
       vm.deal(address(this), 100 ether);
       vm.deal(address(1), 100 ether);
       vm.deal(address(2), 100 ether);
       vm.deal(address(3), 100 ether);
    }

    function testGoodBuy() public {
        lottery.buy{value: 0.1 ether}(0);
    }

    function testInsufficientFunds1() public {
        vm.expectRevert(); //아래 있는 명령어가 실패해야 revert
        lottery.buy(0);
    }

    function testInsufficientFunds2() public {
        vm.expectRevert();
        lottery.buy{value: 0.1 ether - 1}(0);
    }

    function testInsufficientFunds3() public {
        vm.expectRevert();
        lottery.buy{value: 0.1 ether + 1}(0);
    }

    function testNoDuplicate() public {
        lottery.buy{value: 0.1 ether}(0);
        vm.expectRevert();
        lottery.buy{value: 0.1 ether}(0);
    }

    function testSellPhaseFullLength() public { //파는 것 -> 하루
        lottery.buy{value: 0.1 ether}(0);
        vm.warp(block.timestamp + 24 hours - 1);
        vm.prank(address(1)); //사용자를 address(1)로 바꿈
        lottery.buy{value: 0.1 ether}(0);
    }

    function testNoBuyAfterPhaseEnd() public { //시간초과
        lottery.buy{value: 0.1 ether}(0);
        vm.warp(block.timestamp + 24 hours); // time+24hours 후에 실행되게끔
        vm.expectRevert();
        vm.prank(address(1));
        lottery.buy{value: 0.1 ether}(0);
    }

    function testNoDrawDuringSellPhase() public {
        lottery.buy{value: 0.1 ether}(0);
        vm.warp(block.timestamp + 24 hours - 1);
        vm.expectRevert();
        lottery.draw();
    }

    function testNoClaimDuringSellPhase() public {
        lottery.buy{value: 0.1 ether}(0);
        vm.warp(block.timestamp + 24 hours - 1);
        vm.expectRevert();
        lottery.claim();
    }

    function testDraw() public {
        lottery.buy{value: 0.1 ether}(0);
        vm.warp(block.timestamp + 24 hours);
        lottery.draw();
    }

    function getNextWinningNumber() private returns (uint16) {
        uint256 snapshotId = vm.snapshot();
        lottery.buy{value: 0.1 ether}(0);
        vm.warp(block.timestamp + 24 hours);
        lottery.draw();
        uint16 winningNumber = lottery.winningNumber();
        vm.revertTo(snapshotId);
        return winningNumber;
    }

    function testClaimOnWin() public {
        uint16 winningNumber = getNextWinningNumber();
        lottery.buy{value: 0.1 ether}(winningNumber); 
        vm.warp(block.timestamp + 24 hours);
        uint256 expectedPayout = address(lottery).balance; //당첨금
        lottery.draw();
        lottery.claim(); //당첨된 사람한테 돈 주는 거
        console.log(received_msg_value);
        console.log(expectedPayout);
        assertEq(received_msg_value, expectedPayout);
    }

    function testNoClaimOnLose() public {
        uint16 winningNumber = getNextWinningNumber();
        lottery.buy{value: 0.1 ether}(winningNumber + 1); 
        vm.warp(block.timestamp + 24 hours);
        lottery.draw();
        lottery.claim();
        assertEq(received_msg_value, 0);
    }

    function testNoDrawDuringClaimPhase() public {
        uint16 winningNumber = getNextWinningNumber();
        lottery.buy{value: 0.1 ether}(winningNumber); 
        vm.warp(block.timestamp + 24 hours);
        lottery.draw();
        lottery.claim();
        vm.expectRevert();
        lottery.draw();
    }

    function testRollover() public {
        uint16 winningNumber = getNextWinningNumber();
        lottery.buy{value: 0.1 ether}(winningNumber + 1); 
        vm.warp(block.timestamp + 24 hours);
        lottery.draw();
        lottery.claim();

        winningNumber = getNextWinningNumber();
        lottery.buy{value: 0.1 ether}(winningNumber); 
        vm.warp(block.timestamp + 24 hours);
        lottery.draw();
        lottery.claim();
        assertEq(received_msg_value, 0.2 ether);
    }

    function testSplit() public {
        uint16 winningNumber = getNextWinningNumber();
        lottery.buy{value: 0.1 ether}(winningNumber);
        vm.prank(address(1));
        lottery.buy{value: 0.1 ether}(winningNumber);
        vm.deal(address(1), 0);
        vm.warp(block.timestamp + 24 hours);
        lottery.draw();

        lottery.claim();
        assertEq(received_msg_value, 0.1 ether);

        vm.prank(address(1));
        lottery.claim();
        assertEq(address(1).balance, 0.1 ether);
    }

    receive() external payable {
        received_msg_value = msg.value;
    }
}