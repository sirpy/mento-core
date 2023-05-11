// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import { IRegistry } from "../interfaces/IRegistry.sol";

contract WithRegistry {
  event RegistrySet(address indexed registryAddress);
  IRegistry public registry;

  /**
   * @notice Updates the address pointing to a Registry contract.
   * @param registryAddress The address of a registry contract for routing to other contracts.
   */
  function _setRegistry(address registryAddress) private {
    require(registryAddress != address(0), "Cannot register the null address");
    registry = IRegistry(registryAddress);
    emit RegistrySet(registryAddress);
  }
}
