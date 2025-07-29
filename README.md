# BlockWork

Welcome to BlockWork, a decentralized freelance marketplace built on Solana.

## Project Overview

BlockWork is a next-generation freelance marketplace that leverages Solana's blockchain technology to provide secure, transparent, and efficient services for freelancers and clients. The platform focuses on instant, low-fee global payments, transparent on-chain reputation, and innovative dispute resolution mechanisms.

## Core Features

- Secure, on-chain escrow payments using Solana
- Transparent reputation system with on-chain verification
- Global, permissionless access via Solana wallets
- Community-driven dispute resolution
- Integration with DAOs and vertical communities
- Guided onboarding for non-crypto-natives

## Project Structure

```
blockwork-marketplace/
├── docs/              # Project documentation
│   ├── blockwork-proposal/  # Business proposal and market analysis
│   ├── workproof/        # User stories and requirements
│   └── architecture/     # Technical architecture documentation
├── contracts/          # Solana smart contracts
├── frontend/           # Web interface
├── tests/             # Contract and frontend tests
└── diagrams/          # Architecture and flow diagrams
```

## Getting Started

### Prerequisites

- Solana CLI tools
- Phantom or Solflare wallet
- Node.js (for frontend development)
- Rust (for smart contract development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/solana-turbin3/blockwork-marketplace.git
cd blockwork-marketplace
```

2. Install dependencies:
```bash
# Install Rust and Solana CLI if not already installed
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"

# Install Node.js dependencies (for frontend)
cd frontend
npm install
```

### Development

1. Start the Solana local cluster:
```bash
solana-test-validator
```

2. Build and deploy contracts:
```bash
cd contracts
cargo build-bpf
cargo test
```

3. Start the frontend development server:
```bash
cd frontend
npm run dev
```

## Documentation

- [BlockWork Proposal](docs/blockwork-proposal/blockwork-proposal.md)
- [WorkProof Requirements](docs/workproof/workproof.md)
- [Architecture Documentation](docs/architecture/architecture.md)
- [Client Workflow](docs/user_stories/client.md)
- [Admin Workflow](docs/user_stories/admin.md)
- [New User Onboarding](docs/user_stories/new_user.md)

## Security Considerations
- Smart contract audits
- Wallet security
- Rate limiting
- Input validation
- Dispute resolution

## Contributing
[Guidelines will be added]

## License
[License information will be added]
