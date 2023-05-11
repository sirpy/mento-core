// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import { IERC20Metadata } from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import { IERC20Permit } from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol";

/**
 * @title This interface describes the functions specific to Celo Stable Tokens, and in the
 * absence of interface inheritance is intended as a companion to IERC20.sol and ICeloToken.sol.
 */
interface IStableToken is IERC20Metadata, IERC20Permit {
  function mint(address, uint256) external returns (bool);
  function burn(uint256) external returns (bool);
  // function getExchangeRegistryId() external view returns (bytes32);

  // // The following are deprecated
  // function setInflationParameters(uint256, uint256) external;
  // function valueToUnits(uint256) external view returns (uint256);
  // function unitsToValue(uint256) external view returns (uint256);
  // function getInflationParameters()
  //   external
  //   view
  //   returns (
  //     uint256,
  //     uint256,
  //     uint256,
  //     uint256
  //   );
}
