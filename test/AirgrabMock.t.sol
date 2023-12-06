// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.18;

import { Test } from "forge-std-next/Test.sol";
import { console } from "forge-std-next/console.sol";
import { AirgrabMock } from "../contracts/governance/mocks/AirgrabMock.sol";
import { ERC20 } from "openzeppelin-contracts-next/contracts/token/ERC20/ERC20.sol";

contract AirgrabMockTest is Test {
  AirgrabMock testee;
  ERC20 token;

  function setUp() public {
    testee = new AirgrabMock();
    address tokenAddress = address(testee.mentoToken());

    console.log("AirgrabMock deployed at: %s", address(testee));
    console.log("Token address: %s, ", tokenAddress);

    token = ERC20(tokenAddress);
    console.log("Token name: %s", token.name());
  }

  function test_start() public {
    address whale = 0x278160ddcFc0A55026487540AEfD8525ED50fC38;

    bool canClaimBefore = testee.canClaimAddresses(whale);
    console.log("Can claim before toggle: %s", canClaimBefore);

    testee.toggleClaim(whale);

    bool canClaimAfter = testee.canClaimAddresses(whale);
    console.log("Can claim after toggle: %s", canClaimAfter);

    bytes32[] memory proof;
    bytes memory proofAgain;

    uint256 whaleBalanceOfBefore = token.balanceOf(whale);
    console.log("Balance of before: %s", whaleBalanceOfBefore);

    changePrank(whale);
    testee.claim(100, whale, proof, proofAgain, 0, 0, "");

    uint256 whaleBalanceOfAfter = token.balanceOf(whale);
    console.log("Balance of after: %s", whaleBalanceOfAfter);
  }
}
