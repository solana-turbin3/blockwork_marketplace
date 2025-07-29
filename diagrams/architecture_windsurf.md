# Solana Protocol Architecture

```mermaid
graph TD
    %% Style Definitions
classDef program fill:#2196F3,stroke:#333,stroke-width:2px
classDef pda fill:#FFC107,stroke:#333,stroke-width:2px
classDef token fill:#4CAF50,stroke:#333,stroke-width:2px
classDef external fill:#9C27B0,stroke:#333,stroke-width:2px

    %% Core Programs
    P1[Token Manager]:::program
    P2[Staking Manager]:::program
    P3[Governance Manager]:::program

    %% Account Structure
    A1[User Account]:::token
    A2[Staking PDA]:::pda
    A3[Token Vault]:::token

    %% External Services
    O1[Price Oracle]:::external
    C1[Compliance Service]:::external
    M1[Multi-sig Vault]:::external

    %% Program Interactions
    P1 -->|CPI: Transfer| P2
    P2 -->|CPI: Reward| P3
    P3 -->|CPI: Token| P1

    %% Account Relationships
    A1 -->|"Owns"| A2
    A2 -->|"Holds"| A3

    %% External Integrations
    P2 -->|"Price"| O1
    P3 -->|"Check"| C1
    P1 -->|"Vault"| M1

    %% Legend
    subgraph "Legend"
        L1[Program]:::program
        L2[PDA]:::pda
        L3[Token]:::token
        L4[External]:::external
    end
```

## Key Components

### Programs
- Token Manager
- Staking Manager
- Governance Manager

### Account Structure
- User Account
- Staking PDA
- Token Vault

### External Services
- Price Oracle
- Compliance Service
- Multi-sig Vault
