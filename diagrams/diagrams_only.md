# Solana Protocol Architecture Diagrams

## 1. Architecture Overview
```mermaid
graph TD
    %% Style Definitions
classDef program fill:#2196F3,stroke:#333,stroke-width:2px
classDef pda fill:#FFC107,stroke:#333,stroke-width:2px
classDef external fill:#9C27B0,stroke:#333,stroke-width:2px
classDef user fill:#4CAF50,stroke:#333,stroke-width:2px
classDef data fill:#E3F2FD,stroke:#333,stroke-width:1px

    %% Main Architecture Layout
    subgraph "User Interface Layer"
        U1[Web3 Wallet]:::user
        U2[Mobile App]:::user
    end

    subgraph "Core Programs"
        P1[Token Manager]:::program
        P2[Staking Manager]:::program
        P3[Governance Manager]:::program
    end

    subgraph "External Services"
        O1[Price Oracle]:::external
        C1[Compliance Service]:::external
        M1[Multi-sig Vault]:::external
    end

    %% Program Interactions
    P1 -->|"CPI: Transfer"| P2
    P2 -->|"CPI: Reward Distribution"| P3
    P3 -->|"CPI: Token Distribution"| P1

    %% Account Relationships
    U1 -->|"Owns"| P2
    P2 -->|"Holds"| P3
    P3 -->|"Managed by"| P1

    %% External Integrations
    P2 -->|"Get Price"| O1
    P3 -->|"Check Compliance"| C1
    P1 -->|"Vault Access"| M1

    %% Data Flow
    P2 -.->|"Stake Data"| P3
    P3 -.->|"Token Data"| P1
    P1 -.->|"Governance Data"| P2
```

## 2. Account Structure
```mermaid
graph TD
    %% Style Definitions
classDef program fill:#2196F3,stroke:#333,stroke-width:2px
classDef pda fill:#FFC107,stroke:#333,stroke-width:2px
classDef token fill:#2196F3,stroke:#333,stroke-width:2px
classDef system fill:#9C27B0,stroke:#333,stroke-width:2px
classDef data fill:#E3F2FD,stroke:#333,stroke-width:1px

    %% Account Hierarchy
    subgraph "User Accounts"
        U1[User Wallet]:::user
        U2[Staking Account]:::user
        U3[Token Account]:::user
    end

    subgraph "Program Derived Addresses"
        P1[Staking PDA]:::pda
        P2[Rewards PDA]:::pda
        P3[Validator PDA]:::pda
    end

    %% Account Relationships
    U1 -->|"Owns"| U2
    U2 -->|"Holds"| P1
    P1 -->|"Holds"| T1
    T1 -->|"Managed by"| S1

    %% Data Structure Layout
    P1 -->|{"stake_amount": u64
            "activation_time": i64
            "last_update": i64
            "status": u8}:::data| P2

    %% Account Lifecycle
    subgraph "Lifecycle"
        L1[Created]:::process
        L2[Active]:::process
        L3[Locked]:::process
        L4[Closed]:::process
        L1 --> L2
        L2 --> L3
        L3 --> L4
    end
```

## 3. Staking Flow
```mermaid
graph TD
    %% Style Definitions
classDef program fill:#2196F3,stroke:#333,stroke-width:2px
classDef function fill:#E3F2FD,stroke:#333,stroke-width:1px
classDef pda fill:#FFC107,stroke:#333,stroke-width:2px
classDef external fill:#9C27B0,stroke:#333,stroke-width:2px
classDef user fill:#4CAF50,stroke:#333,stroke-width:2px
classDef data fill:#E3F2FD,stroke:#333,stroke-width:1px

    %% Main Flow
    subgraph "Staking Process"
        SP[Staking Program]:::program
        SP -->|"User Deposits"| D1{Check User Status}:::decision

        D1 -->|"New User"| P1[Create New Account]:::process
        D1 -->|"Existing User"| P2[Verify Account]:::process

        P1 --> A1[User Staking Account]:::pda
        P2 --> A1

        A1 -->|"Deposit"| D2{Check Balance}:::decision
        D2 -->|"Insufficient"| P3[Request More SOL]:::process
        D2 -->|"Sufficient"| P4[Create Stake Entry]:::process

        P4 --> P5[Create Staking PDA]:::process
        P5 --> PDA1[Staking PDA]:::pda

        PDA1 -->|"Get Price"| E1[Price Oracle]:::external
        E1 --> PDA1

        PDA1 -->|"Calculate Rewards"| D3{Check Rewards}:::decision
        D3 -->|"No Rewards"| P6[Wait for Next Epoch]:::process
        D3 -->|"Has Rewards"| P7[Distribute Rewards]:::process
    end
```

## 4. External Integrations
```mermaid
graph TD
    %% Style Definitions
classDef program fill:#2196F3,stroke:#333,stroke-width:2px
classDef pda fill:#FFC107,stroke:#333,stroke-width:2px
classDef external fill:#9C27B0,stroke:#333,stroke-width:2px
classDef data fill:#E3F2FD,stroke:#333,stroke-width:1px

    %% External Services
    subgraph "Price Oracle"
        O1[Oracle Service]:::external
        O1 -->|"Provide Prices"| P1[Price Data]:::data
    end

    subgraph "Compliance"
        C1[Compliance Service]:::external
        C1 -->|"Verify"| C2[Compliance Data]:::data
    end

    subgraph "Multi-sig"
        M1[Multi-sig Vault]:::external
        M1 -->|"Manage"| M2[Signatures]:::data
    end

    %% Integration Points
    P1 -->|"Update"| P2[Program]:::program
    C2 -->|"Validate"| P2
    M2 -->|"Authorize"| P2
```

## 5. Diagram Legends
```mermaid
graph TD
    subgraph "Legend"
        L1[Program]:::program
        L2[Function]:::function
        L3[PDA]:::pda
        L4[External]:::external
        L5[User]:::user
        L6[Data]:::data
    end
```
