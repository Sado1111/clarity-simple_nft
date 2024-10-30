# Simple NFT Contract

A basic NFT (Non-Fungible Token) implementation in Clarity 2.0 for the Stacks ecosystem. This contract provides core NFT functionality including minting and transferring tokens.

## Features

- NFT minting (contract owner only)
- Token transfers
- Token URI storage and retrieval
- Owner lookup
- Implements standard NFT trait

## Contract Details

The contract implements these main functions:

- `mint`: Creates a new NFT with associated token URI
- `transfer`: Transfers NFT ownership between addresses
- `get-token-uri`: Retrieves token metadata URI
- `get-owner`: Looks up token owner
- `get-last-token-id`: Returns the most recently minted token ID

## Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet)
- [Stacks CLI](https://docs.stacks.co/docs/cli-installation)

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/clarity-simple-nft.git
cd clarity-simple-nft
```

2. Install dependencies:
```bash
clarinet requirements
```

## Testing

Run the test suite:
```bash
clarinet test
```

## Usage

### Initialize Contract

```bash
clarinet console
```

### Mint NFT

```clarity
(contract-call? .simple-nft mint "ipfs://YOUR_TOKEN_URI")
```

### Transfer NFT

```clarity
(contract-call? .simple-nft transfer u1 tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

## Error Codes

- `u100`: Not contract owner
- `u101`: Not token owner
- `u102`: Token already exists
- `u103`: Token not found

## Security Considerations

- Only the contract owner can mint new tokens
- Token transfers require ownership verification
- Non-transferable owner rights
- Protected against common NFT vulnerabilities

## License

MIT License

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request