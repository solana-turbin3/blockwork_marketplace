# Solana Protocol Architecture

This document outlines the comprehensive architecture of the Solana protocol implementation, following the Solana Protocol Architecture guidelines. The architecture is broken down into three main components, each with its own detailed diagram.

## 1. Program Structure

```mermaid
%% Program Structure Diagram
flowchart TD
    %% Styling
    classDef program fill:#4E79A7,stroke:#2E4A6E,color:white,stroke-width:2px,font-weight:bold
    classDef instruction fill:#76B7B2,stroke:#4E8C8A,color:white,stroke-width:1.5px
    classDef cpi fill:#F28E2B,stroke:#B66D1F,color:white,stroke-width:1.5px
    
    %% Programs
    TM[Token Program]
    SM[Staking Program]
    GM[Governance Program]
    
    %% Token Program Instructions
    subgraph TM_Instructions[ ]
        TM1[Transfer]
        TM2[Mint/Burn]
        TM3[Approve/Revoke]
        TM4[Get Balance]
    end
    
    %% Staking Program Instructions
    subgraph SM_Instructions[ ]
        SM1[Create Stake]
        SM2[Withdraw Stake]
        SM3[Claim Rewards]
    end
    
    %% Governance Program Instructions
    subgraph GM_Instructions[ ]
        GM1[Create Proposal]
        GM2[Cast Vote]
        GM3[Execute Proposal]
    end
    
    %% CPIs
    CPI1[Transfer Tokens]
    CPI2[Stake Tokens]
    CPI3[Vote with Staked Tokens]
    
    %% Program Connections
    TM -->|CPI| SM
    SM -->|CPI| GM
    
    %% Instructions to Programs
    TM --> TM_Instructions
    SM --> SM_Instructions
    GM --> GM_Instructions
    
    %% CPIs to Instructions
    CPI1 -.-> TM1
    CPI2 -.-> SM1
    CPI3 -.-> GM2
    
    %% Styling
    class TM,SM,GM program
    class TM1,TM2,TM3,TM4,SM1,SM2,SM3,GM1,GM2,GM3 instruction
    class CPI1,CPI2,CPI3 cpi
    
    %% Legend
    legend[Program Interactions]
    legend -->|1. Token Program| TM
    legend -->|2. Staking Program| SM
    legend -->|3. Governance Program| GM
    
    style legend fill:#f9f9f9,stroke:#ddd,stroke-width:1px
```

### Key Components:
- **Token Program**: Handles token transfers, minting, and balance management
- **Staking Program**: Manages staking operations and reward calculations
- **Governance Program**: Handles proposal creation, voting, and execution

## 2. Account Structure

```mermaid
%% Account Structure Diagram
flowchart TD
    %% Styling
    classDef account fill:#59A14F,stroke:#3A6B33,color:white,stroke-width:2px,font-weight:bold
    classDef pda fill:#F28E2B,stroke:#B66D1F,color:white,stroke-width:2px,font-weight:bold
    classDef system fill:#E15759,stroke:#A73638,color:white,stroke-width:2px,font-weight:bold
    classDef field fill:#f9f9f9,stroke:#ddd,stroke-width:1px
    
    %% User Accounts
    subgraph UserAccounts[User Accounts]
        direction TB
        UA[User Wallet]
        
        subgraph TokenAccounts[Token Accounts]
            TA1[Token Account 1]
            TA2[Token Account 2]
        end
        
        subgraph StakeAccounts[Stake Accounts]
            SA1[Stake Account 1]
            SA2[Stake Account 2]
        end
        
        UA --> TokenAccounts
        UA --> StakeAccounts
    end
    
    %% PDAs
    subgraph PDAs[Program Derived Addresses]
        direction TB
        
        subgraph StakingPDA[Staking PDAs]
            SPDA1[Staking PDA 1]
            SPDA2[Staking PDA 2]
        end
        
        subgraph GovernancePDA[Governance PDAs]
            GPDA1[Proposal PDA]
            GPDA2[Vote PDA]
        end
        
        subgraph VaultPDA[Vault PDAs]
            VPDA1[Token Vault]
            VPDA2[Rewards Vault]
        end
    end
    
    %% System Accounts
    subgraph System[System Accounts]
        direction TB
        
        subgraph Programs[Core Programs]
            SYS[System Program]
            TOK[Token Program]
            STAKE[Stake Program]
        end
        
        subgraph Sysvars[Sysvars]
            CLK[Clock]
            EPOCH[Epoch Schedule]
            RENT[Rent]
        end
    end
    
    %% Relationships
    UserAccounts --> PDAs
    PDAs --> System
    
    %% Styling
    class UA,TA1,TA2,SA1,SA2 account
    class SPDA1,SPDA2,GPDA1,GPDA2,VPDA1,VPDA2 pda
    class SYS,TOK,STAKE,CLK,EPOCH,RENT system
    
    %% Legend
    legend[Account Types]
    legend -->|User Account| UA
    legend -->|PDA| SPDA1
    legend -->|System Program| SYS
    
    style legend fill:#f9f9f9,stroke:#ddd,stroke-width:1px
```

### Account Types:
- **User Accounts**: Owned by users, contain SOL and token balances
- **Program Derived Addresses (PDAs)**: Stateless accounts managed by programs
- **System Accounts**: Core Solana system accounts and programs

## 3. External Integrations

```mermaid
%% External Integrations Diagram
flowchart TD
    %% Styling
    classDef external fill:#B07AA1,stroke:#7D5772,color:white,stroke-width:2px,font-weight:bold
    classDef oracle fill:#4E79A7,stroke:#2E4A6E,color:white,stroke-width:2px,font-weight:bold
    classDef compliance fill:#E15759,stroke:#A73638,color:white,stroke-width:2px,font-weight:bold
    classDef multisig fill:#F28E2B,stroke:#B66D1F,color:white,stroke-width:2px,font-weight:bold
    classDef program fill:#59A14F,stroke:#3A6B33,color:white,stroke-width:2px,font-weight:bold
    
    %% Core Programs
    subgraph Programs[Core Programs]
        direction TB
        TP[Token Program]
        SP[Staking Program]
        GP[Governance Program]
    end
    
    %% Oracle Integration
    subgraph Oracle[Price Oracle]
        direction TB
        O1[Price Feed API]
        O2[Data Verification]
        O3[On-chain Update]
        
        O1 -->|Fetch| O2
        O2 -->|Verify| O3
    end
    
    %% Compliance Service
    subgraph Compliance[Compliance Service]
        direction TB
        C1[KYC/AML Check]
        C2[Sanctions Screening]
        C3[Risk Analysis]
        
        C1 --> C2
        C2 --> C3
    end
    
    %% Multi-sig Vault
    subgraph MultiSig[Multi-sig Vault]
        direction TB
        M1[Propose Transaction]
        M2[Approve (n/m)]
        M3[Execute]
        
        M1 --> M2
        M2 --> M3
    end
    
    %% Integration Points
    TP <-->|1. Price Data| Oracle
    TP <-->|2. Compliance Check| Compliance
    TP <-->|3. Multi-sig Control| MultiSig
    
    SP <-->|4. Oracle Data| Oracle
    GP <-->|5. Multi-sig| MultiSig
    
    %% Styling
    class TP,SP,GP program
    class O1,O2,O3 oracle
    class C1,C2,C3 compliance
    class M1,M2,M3 multisig
    
    %% Legend
    legend[Integration Points]
    legend -->|1. Token Pricing| Oracle
    legend -->|2. Regulatory Compliance| Compliance
    legend -->|3. Secure Transfers| MultiSig
    
    style legend fill:#f9f9f9,stroke:#ddd,stroke-width:1px
```

### Integration Points:
- **Price Oracle**: Provides real-time price feeds for assets
- **Compliance Service**: Handles KYC/AML and regulatory requirements
- **Multi-sig Vault**: Enables secure, multi-signature transactions

## Flow Components

### Staking Flow
1. User deposits tokens into staking account
2. Staking program creates stake account
3. Rewards accrue based on staking duration
4. User can claim rewards or unstake tokens

### Governance Flow
1. Token holders create proposals
2. Voting period begins
3. Votes are tallied on-chain
4. Successful proposals are executed

## Security Considerations
- All programs implement proper access control
- Critical operations require proper authorization
- External calls are validated and rate-limited
- Comprehensive test coverage for all programs
