// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.18;

import { Ownable } from "openzeppelin-contracts-next/contracts/access/Ownable.sol";
import { PooCoinMock } from "./PooCoinMock.sol";

contract AirgrabMock is Ownable {
  mapping(address account => bool canClaim) public canClaimAddresses;
  PooCoinMock public mentoToken;

  constructor() {
    mentoToken = new PooCoinMock(address(this));
  }

  function toggleClaim(address targetAddress) public {
    canClaimAddresses[targetAddress] = !canClaimAddresses[targetAddress];
  }

  function claim(
    uint96 amount,
    address delegate,
    bytes32[] calldata merkleProof,
    bytes calldata fractalProof,
    uint256 fractalProofValidUntil,
    uint256 fractalProofApprovedAt,
    string memory fractalId
  ) public {
    require(canClaimAddresses[msg.sender], "Address cannot claim");
    mentoToken.mint(msg.sender, amount);
  }
}
