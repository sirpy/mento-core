// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.18;

import { Ownable } from "openzeppelin-contracts-next/contracts/access/Ownable.sol";
import { PooCoinMock } from "./PooCoinMock.sol";

contract AirgrabMock is Ownable {
  mapping(address account => bool canClaim) public canClaimAddresses;
  mapping(address account => bool claimed) public hasClaimed;
  PooCoinMock public mentoToken;

  constructor() {
    mentoToken = new PooCoinMock(address(this));
  }

  function toggleClaim(address targetAddress) public {
    canClaimAddresses[targetAddress] = !canClaimAddresses[targetAddress];
  }

  function toggleClaimed(address targetAddress) public {
    hasClaimed[targetAddress] = !hasClaimed[targetAddress];
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
    require(!hasClaimed[msg.sender], "Address has already claimed");

    hasClaimed[msg.sender] = true;

    mentoToken.mint(msg.sender, amount);
  }

  function checkHasClaimed(address account) public returns (bool) {
    return hasClaimed[account];
  }

  function checkCanClaim(address account) public returns (bool) {
    return canClaimAddresses[account];
  }
}
