// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import { IStableToken } from "../interfaces/ISTableToken.sol";
import { ERC20PermitUpgradeable } from "./oz-overrides/ERC20PermitUpgradeable.sol";

contract MentoERC20 is ERC20PermitUpgradeable  {
  bytes32 private constant VALIDATORS_REGISTRY_ID = keccak256(abi.encodePacked("Validators"));
  bytes32 private constant BROKER_REGISTRY_ID = keccak256(abi.encodePacked("Broker"));

  function initializeV2() external reinitializer(2) onlyOwner {
    __ERC20Permit_init(symbol());
  }

  /**
   * @notice Mints new StableToken and gives it to 'to'.
   * @param to The account for which to mint tokens.
   * @param value The amount of StableToken to mint.
   */
  function mint(address to, uint256 value) external returns (bool) {
    require(
      msg.sender == registry.getAddressFor(BROKER_REGISTRY_ID) ||
        msg.sender == registry.getAddressFor(VALIDATORS_REGISTRY_ID),
      "Sender not authorized to mint"
    );
    _mint(to, value);
    return true;
  }

  /**
   * @notice Burns StableToken from the balance of msg.sender.
   * @param value The amount of StableToken to burn.
   */
  function burn(uint256 value) external returns (bool) {
    require(
      msg.sender == registry.getAddressFor(BROKER_REGISTRY_ID),
      "Sender not authorized to burn"
    );
    _burn(msg.sender, value);
    return true;
  }
}
