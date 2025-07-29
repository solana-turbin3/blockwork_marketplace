# WorkProof: Final Project Deliverable

## Part A: User Stories & On-Chain Requirements

### Core User Personas
- Freelancer: Seeks global work opportunities and secure, fast payment.
- Client: Posts jobs, selects talent, and pays for completed work.
- New User: Needs simple onboarding and wallet connection.
- Admin: Oversees platform activity and resolves disputes.

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
