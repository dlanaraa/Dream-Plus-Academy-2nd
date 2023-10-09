// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Pyramid.sol";

contract PyramidTest is Test {
    Pyramid public pyramid;

    function setUp() public {
        pyramid = new Pyramid();
    }

    function subtestPyramid(uint size) public {
        bytes memory str = bytes(pyramid.run(size));
        assertEq(str.length, size * (size + 1) / 2 + size);
        uint j = 0;
        uint t = 1;
        uint a = 0;
        for (uint i = 0; i < str.length; i++) {
            if (str[i] == '\n') {
                a |= t ^ i;
                j += 1;
                t += j + 2;
            } else {
                assertEq(str[i], '*');
            }
        }
        assertEq(a, 0);
    }

    function testPyramid0() public {
        assertEq(pyramid.run(0), "");
    }

    function testPyramid3() public {
        assertEq(pyramid.run(3), "*\n**\n***\n");
    }

    function testPyramid5() public {
        assertEq(pyramid.run(5), "*\n**\n***\n****\n*****\n");
    }

    function testPyramidN() public {
        for (uint size = 1; size <= 30; size++) {
            subtestPyramid(size);
        }
    }
}
