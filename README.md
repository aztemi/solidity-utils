# solidity-utils

Utility extensions for solidity smart contracts

## Available extensions

Below is the only contract extension made available at the moment. More are planned for later.

### 1. RandomIDsGenerator.sol

It randomly generates number IDs. It can be used to assign token IDs for a random mint.

**Usage:**

```solidity
// Step 1. Import the RandomIDsGenerator contract
import "@aztemi/solidity-utils/contracts/RandomIDsGenerator.sol";

// Step 2. Derive your contract from it
contract MyContract is RandomIDsGenerator {
  uint256 constant NFT_MAX_SUPPLY = 1000;

  // Step 3. Initialize with the max amount of IDs supply
  constructor() RandomIDsGenerator(NFT_MAX_SUPPLY) {}

  function getRandomTokenID() public returns (uint256) {
    // Step 4. Generate next random ID
    uint256 tokenId = _nextID();

    return tokenId;
  }

  // No of NFTs available for minting
  function availableSupply() public view returns (uint256) {
    // Step 5 (Optional). Get number of IDs remaining
    return _remainingSupply();
  }

  // No of NFTs already minted
  function mintedSupply() public view returns (uint256) {
    return NFT_MAX_SUPPLY - _remainingSupply();
  }

  // Total number of NFTs
  function maxSupply() public pure returns (uint256) {
    return NFT_MAX_SUPPLY;
  }
}
```
