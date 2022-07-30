// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Random IDs Generator
 * @author t4top@aztemi
 * @dev Randomly generates number IDs. This can be used to assign token IDs for random mint.
 */

abstract contract RandomIDsGenerator {
  uint256 remain = 0; // number of IDs remaining
  mapping(uint256 => uint256) taken; // list of IDs already assigned

  constructor(uint256 _amount) {
    remain = _amount;
  }

  function random(uint256 _modulus) internal view returns (uint256) {
    // 1 added since uint256 cast is a rounddown operation
    return (1 + uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, _modulus))) % _modulus);
  }

  // get the next random ID
  function nextID() internal returns (uint256) {
    assert(remain > 0);
    uint256 id = random(remain);
    uint256 value = taken[id];

    while (value > 0) {
      taken[id] = remain;
      id = value;
      value = taken[id];
    }

    taken[id] = remain;
    remain--;

    return id;
  }

  // number of IDs remaining
  function remainingSupply() internal view returns (uint256) {
    return remain;
  }
}
