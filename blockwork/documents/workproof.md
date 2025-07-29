# WorkProof: Final Project Deliverable

## Part A: User Stories & On-Chain Requirements

### Core User Personas
- Freelancer: Seeks global work opportunities and secure, fast payment
- Client: Posts jobs, selects talent, and pays for completed work
- New User: Needs simple onboarding and wallet connection
- Admin: Oversees platform activity and resolves disputes

### Function Maps

#### Freelancer
- Apply for a job
- Submit completed work for a job
- Receive payment after work is accepted

#### Client
- Post a new job
- Choose a freelancer for a job
- Add money to a job contract
- Release payment to freelancer after work is delivered

#### New User
- Connect digital wallet to the platform
- Get help if having trouble connecting wallet

#### Admin
- Review and resolve disagreements between clients and freelancers
- Check activity on the platform

### On-Chain Requirements

#### Freelancer Actions
- Apply for a job:
  - Function to submit application to job's on-chain account
  - Store freelancer's address and application details
  - Prevent duplicate applications

- Submit completed work:
  - Function to submit work proof to job's on-chain account
  - Store hash/link to submitted work
  - Record submission timestamp
  - Only selected freelancer can submit work

- Receive payment after work is accepted:
  - Function to release escrowed funds to freelancer
  - Only after client approval
  - Update job status to "completed" and record payment

#### Client Actions
- Post a new job:
  - Function to create new on-chain job account
  - Store job details, client address, status
  - Assign unique job identifier

- Choose a freelancer:
  - Function to select freelancer from applicants
  - Update job account with selected freelancer's address
  - Prevent multiple selections

- Add money to job contract:
  - Function to fund escrow account linked to job
  - Store escrowed amount and client address
  - Prevent overfunding

- Release payment after work delivered:
  - Function to approve work and release escrowed funds
  - Only client can approve/release payment
  - Update job status to "paid" or "completed"

#### New User Actions
- Connect digital wallet:
  - Require wallet signature to authenticate actions on-chain
  - Store user public key for transactions/permissions

- Get help connecting wallet:
  - (Mostly off-chain, but may log failed connection attempts on-chain if needed)

#### Admin Actions
- Review/resolve disputes:
  - Function to flag job as "in dispute" on-chain
  - Admin can resolve dispute and trigger fund release/refund
  - Record dispute and resolution in job account

- Check platform activity:
  - On-chain logs/events for all key actions
  - Admin can query/review logs

## Part A: Initial User & Function Mapping

### BlockWork Project Value Proposition
BlockWork is a decentralized freelance marketplace on Solana that ensures secure escrow payments and trustworthy reputation for freelancers and clients globally. It offers low fees, simple wallet onboarding, and permissionless participation.

### User Type Prioritization

#### Final Prioritized User Types
- Freelancers
  - Rationale: Essential for demonstrating secure escrow payments and reputation-building

- Clients / Employers
  - Rationale: Source of job postings and payments, fundamental for validating marketplace and escrow/payment flow

- New Users (Onboarding)
  - Rationale: Critical for adoption, ensures platform is accessible and user-friendly

- Platform Administrators
  - Rationale: Needed for dispute resolution, manual oversight, and building trust

## Adversarial Analysis & Granularity Check

### Potential Attack Vectors

#### Smart Contract Vulnerabilities
- Reentrancy attacks on escrow contracts
- Incorrect fund release logic allowing double-spending or premature release
- Integer overflows/underflows affecting contract balances

#### User Authentication & Wallet Security
- Phishing attacks targeting users during wallet connection
- Private key exposure through insecure storage or social engineering

#### Job & Application Manipulation
- Fake job postings to scam freelancers
- Sybil attacks to manipulate reputation or feedback
- Freelancer collusion to game the escrow or feedback system

#### Payment & Escrow Risks
- Client refusal to release funds after work is delivered
- Freelancer abandonment after receiving partial payment
- Front-running of job applications or contract selection

#### Platform Admin & Off-chain Risks
- Backend API compromise leaking sensitive metadata
- Database tampering with job or user records
- Denial-of-service attacks on API or frontend
