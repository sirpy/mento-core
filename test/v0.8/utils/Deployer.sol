// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import { CommonBase } from "forge-std-v08/Base.sol";

contract Deployer is CommonBase {
  address public constant deployer = address(0x31337);
  function deploy(string memory path, bytes memory args) public returns (address) {
    bytes memory bytecode = abi.encodePacked(vm.getCode(path), args);
    address addr;
    vm.startPrank(deployer);
    assembly {
      addr := create(0, add(bytecode, 0x20), mload(bytecode))
    }
    return addr;
  }

  function deployAt(string memory path, bytes memory args, address addr) public returns (address) {
    address temp = deploy(path, args);
    vm.etch(addr, temp.code);
  }

  function newStableToken() public returns (address) {
    return deploy("../v0.5/StableToken.sol:StableToken", abi.encode(true));
  }

  function newRegistry(address dest) public returns (address) {
     deployAt("../v0.5/Registry.sol:Registry", abi.encode(true), dest);
  }
}
