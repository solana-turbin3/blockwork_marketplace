```mermaid
graph TD
    subgraph "Token Program"
        TP[Token Manager]:::program
        TP -->|"Creates"| T1
        TP -->|"Creates"| T2
        TP -->|"Creates"| T3
    end

    subgraph "Staking Program"
        SP[Staking Manager]:::program
        SP -->|"Creates"| S1
        SP -->|"Creates"| S2
        SP -->|"Creates"| S3
    end

    subgraph "Governance Program"
        GP[Governance Manager]:::program
        GP -->|"Creates"| G1
        GP -->|"Creates"| G2
    end

    %% Regular Accounts
    subgraph "User Accounts"
        UA1[User Wallet 1]:::account
        UA1 -->|"Owner:"| UA1_owner[User 1 Public Key]:::owner
        UA1 -->|"Data:"| UA1_data["Balance: 100 SOL\nNonce: 12345"]:::data
        
        UA2[User Wallet 2]:::account
        UA2 -->|"Owner:"| UA2_owner[User 2 Public Key]:::owner
        UA2 -->|"Data:"| UA2_data["Balance: 50 SOL\nNonce: 67890"]:::data
    end

    %% Token Accounts
    T1[Token Account 1]:::token_account
    T1 -->|"Owner:"| UA1:::owner
    T1 -->|"Data:"| T1_data["Mint: USDC\nAmount: 10000\nDecimals: 6"]:::data

    T2[Token Account 2]:::token_account
    T2 -->|"Owner:"| UA2:::owner
    T2 -->|"Data:"| T2_data["Mint: USDT\nAmount: 5000\nDecimals: 6"]:::data

    T3[Token Vault]:::token_account
    T3 -->|"Owner:"| GP:::owner
    T3 -->|"Data:"| T3_data["Mint: SOL\nAmount: 100000\nDecimals: 9"]:::data

    %% Staking Accounts
    S1[Staking Account 1]:::staking_account
    S1 -->|"Owner:"| UA1:::owner
    S1 -->|"Data:"| S1_data["Stake Amount: 50 SOL\nUnlock Date: 2025-08-28"]:::data

    S2[Staking Account 2]:::staking_account
    S2 -->|"Owner:"| UA2:::owner
    S2 -->|"Data:"| S2_data["Stake Amount: 25 SOL\nUnlock Date: 2025-09-28"]:::data

    S3[Staking Pool]:::staking_account
    S3 -->|"Owner:"| SP:::owner
    S3 -->|"Data:"| S3_data["Total Staked: 5000 SOL\nAPR: 8%\nLast Update: 2025-07-28"]:::data

    %% PDA Accounts
    subgraph "PDAs"
        PDA1[Staking PDA 1]:::pda
        PDA1 -->|"Derived from:"| PDA1_seeds["Seeds:\n- 'staking'\n- User 1 Key"]:::pda_info
        PDA1 -->|"Owner:"| SP:::owner
        PDA1 -->|"Data:"| PDA1_data["Stake Amount: 50 SOL\nRewards: 1.2 SOL\nLast Update: 2025-07-28"]:::data

        PDA2[Token PDA 2]:::pda
        PDA2 -->|"Derived from:"| PDA2_seeds["Seeds:\n- 'token'\n- User 2 Key"]:::pda_info
        PDA2 -->|"Owner:"| TP:::owner
        PDA2 -->|"Data:"| PDA2_data["Token Balance: 1000 USDC\nLast Update: 2025-07-28"]:::data

        PDA3[Governance PDA]:::pda
        PDA3 -->|"Derived from:"| PDA3_seeds["Seeds:\n- 'governance'\n- Proposal ID"]:::pda_info
        PDA3 -->|"Owner:"| GP:::owner
        PDA3 -->|"Data:"| PDA3_data["Proposal ID: 001\nStatus: Active\nVotes: 10000"]:::data
    end

    %% Account Hierarchy
    subgraph "Account Hierarchy"
        U1[User Wallet]:::account
        U2[Staking Account]:::staking_account
        U3[Token Account]:::token_account
    end

    subgraph "Program Derived Addresses"
        P1[Staking PDA]:::pda
        P2[Rewards PDA]:::pda
        P3[Validator PDA]:::pda
    end

    subgraph "Token Accounts"
        T1[Token Vault]:::token_account
        T2[Rewards Vault]:::token_account
        T3[Stake Vault]:::token_account
    end

    subgraph "System Accounts"
        S1[System Config]:::program
        S2[Epoch Info]:::program
        S3[Fee Account]:::program
    end

    %% Account Relationships
    UA1 -->|"Owns"| S1
    UA2 -->|"Owns"| S2
    S1 -->|"Holds"| PDA1
    S2 -->|"Holds"| PDA2
    PDA1 -->|"Holds"| T1
    PDA2 -->|"Holds"| T2
    T1 -->|"Managed by"| S1
    T2 -->|"Managed by"| S2

    %% Data Structure Layout
    PDA1 -->|{"stake_amount": u64
            "activation_time": i64
            "last_update": i64
            "status": u8}:::data| PDA2

    PDA2 -->|{"reward_amount": u64
            "accumulated_points": u64
            "last_claimed": i64}:::data| PDA3

    %% Account Lifecycle
    subgraph "Lifecycle"
        L1[Created]:::process
        L2[Active]:::process
        L3[Locked]:::process
        L4[Closed]:::process

        %% State Transitions
        L1 --> L2
        L2 --> L3
        L3 --> L4
    end

    %% Legend
    subgraph "Legend"
        L1[User Account]:::account
        L2[Program PDA]:::pda
        L3[Token Account]:::token_account
        L4[System Account]:::program
        L5[Data Structure]:::data
    end

    %% PDA Derivation Process
    subgraph "PDA Derivation"
        direction TB
        PDA_Derivation["PDA Derivation Process"]:::process
        PDA_Derivation -->|"1. Combine Seeds"| Seeds["Seeds:\n- 'staking'\n- User Key"]:::process
        Seeds -->|"2. Hash with Program ID"| Hash["Hash with SP ID"]:::process
        Hash -->|"3. Create Address"| PDA1
    end
```
