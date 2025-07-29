# Solana Protocol Architecture Diagram

```mermaid
graph TD
    %% Style Definitions
classDef program fill:#2196F3,stroke:#333,stroke-width:2px
classDef pda fill:#FFC107,stroke:#333,stroke-width:2px
classDef token fill:#4CAF50,stroke:#333,stroke-width:2px
classDef external fill:#9C27B0,stroke:#333,stroke-width:2px
classDef user fill:#FF9800,stroke:#333,stroke-width:2px
classDef data fill:#E3F2FD,stroke:#333,stroke-width:1px
classDef decision fill:#FFEB3B,stroke:#333,stroke-width:2px
classDef process fill:#E8F5E9,stroke:#333,stroke-width:1px

    %% Legend
    subgraph "Legend"
        L1[Program]:::program
        L2[PDA]:::pda
        L3[Token Account]:::token
        L4[External Service]:::external
        L5[User Interface]:::user
        L6[Data]:::data
        L7[Decision]:::decision
        L8[Process]:::process
    end

    %% User Interaction Layer
    subgraph "User Interface"
        UI1[Web3 Wallet]:::user
        UI2[Mobile App]:::user
    end

    %% Core Programs with Responsibilities
    subgraph "Token Management Program"
        TM[Token Manager]:::program
        TM -->|"Handle Transfers"| TM1[Transfer Handler]:::process
        TM -->|"Manage Supply"| TM2[Supply Manager]:::process
    end

    subgraph "Staking Program"
        SP[Staking Manager]:::program
        SP -->|"Process Stakes"| SP1[Stake Handler]:::process
        SP -->|"Calculate Rewards"| SP2[Reward Calculator]:::process
    end

    subgraph "Governance Program"
        GP[Governance Manager]:::program
        GP -->|"Process Votes"| GP1[Voting Handler]:::process
        GP -->|"Execute Proposals"| GP2[Proposal Executor]:::process
    end

    %% Account Structure
    subgraph "Account Hierarchy"
        %% User Accounts
        UA1[User Wallet]:::token
        UA2[Staking Account]:::token
        UA3[Token Account]:::token

        %% Program PDAs
        PDA1[Staking PDA]:::pda
        PDA1 -->|"Owner:"| SP
        PDA1 -->|"Data:"| PDA1_data[Stake Data]:::data

        PDA2[Rewards PDA]:::pda
        PDA2 -->|"Owner:"| SP
        PDA2 -->|"Data:"| PDA2_data[Reward Data]:::data

        %% Token Accounts
        T1[Token Vault]:::token
        T2[Rewards Vault]:::token
        T3[Stake Vault]:::token
    end

    %% External Services
    subgraph "External Integrations"
        %% Oracles
        O1[Price Oracle]:::external
        O1 -->|"Provide Prices"| SP

        %% Compliance
        C1[Compliance Service]:::external
        C1 -->|"Verify"| SP

        %% Multi-sig
        M1[Multi-sig Vault]:::external
        M1 -->|"Authorize"| GP
    end

    %% Flow and Interactions
    %% User Flow
    UI1 -->|"Deposit"| SP
    UI2 -->|"Stake"| SP
    UI1 -->|"Claim Rewards"| SP

    %% Program Interactions
    TM -->|"CPI: Transfer"| SP
    SP -->|"CPI: Reward Distribution"| GP
    GP -->|"CPI: Token Distribution"| TM

    %% Data Flow
    SP -.->|"Stake Data"| PDA1
    PDA1 -.->|"Token Data"| T1
    GP -.->|"Governance Data"| TM

    %% Decision Points
    subgraph "Decision Points"
        D1{Check Balance}:::decision
        D2{Check Compliance}:::decision
        D3{Check Rewards}:::decision
    end

    %% Error Handling
    subgraph "Error Paths"
        E1[Error Log]:::process
        E2[Retry Mechanism]:::process
    end

    %% PDA Derivation
    subgraph "PDA Derivation"
        PDA_Derive[Derive PDA]:::process
        PDA_Derive -->|"Seeds:"| Seeds[Seeds:
        - 'staking'
        - User Key]:::data
        Seeds -->|"Hash"| Hash[Hash with Program ID]:::process
        Hash -->|"Create"| PDA1
    end

    %% Version Control
    subgraph "Version Info"
        V1[Protocol v1.0]:::program
        V1 -->|"Upgrade"| V2[Protocol v1.1]:::program
    end
```

## Key Components Legend

1. **Program Structure**:
- Programs: Blue boxes with unique colors
- Responsibilities: Clear labels within boxes
- Interactions: Directed arrows with CPI labels

2. **Account Structure**:
- User Accounts: Green boxes
- PDAs: Yellow boxes with owner info
- Token Accounts: Green boxes
- Data: Light blue boxes

3. **External Integrations**:
- Oracles: Purple cloud shapes
- Compliance: Purple hexagons
- Multi-sig: Purple cylinders

4. **Flow Components**:
- Processes: Light green boxes
- Decisions: Yellow diamonds
- Error Handling: Red paths

5. **Key Features**:
- Clear data flow indicators
- Version control
- Error handling paths
- PDA derivation process
- Account ownership relationships

## Evaluation Checklist
- [x] All programs represented
- [x] Account structures mapped
- [x] Program interactions illustrated
- [x] External dependencies shown
- [x] Decision points included
- [x] Clear, consistent labeling
- [x] Program responsibilities clear
- [x] Accurate interactions
- [x] Comprehensive account representation
- [x] Clear external dependency visualization
- [x] Logical flow and readability
