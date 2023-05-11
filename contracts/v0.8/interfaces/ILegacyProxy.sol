// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

interface ILegacyProxy {
  function _setImplementation(address implementation) external;
  function _setAndInitializeImplementation(address implementation, bytes calldata data) external payable;
  function _getImplementation() external view returns (address);
  function _getOwner() external view returns (address);
  function _setOwner() external;
}
