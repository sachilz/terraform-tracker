# 📘 Day 4: State Management & Remote Backend (S3 + DynamoDB)

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Understand the role of `terraform.tfstate` (Single Source of Truth).
- Why storing `.tfstate` in Git is dangerous (plaintext secrets, merge conflicts, lack of locking).
- Setup **Remote Backend** using AWS S3.
- Implement **State Locking** using AWS DynamoDB to prevent concurrent executions by team members.
- Practice state commands (`state list`, `state show`, `state rm`, `state mv`).

---

## 📂 Architecture
```text
Day-4/
├── README.md
├── backend_infra/             # Step 1: Provisions S3 Bucket + DynamoDB Table
│   ├── main.tf
│   └── outputs.tf
└── main.tf                    # Step 2: The workload using the S3 remote backend
```

---

## 🚀 Step-by-Step Hands-on

### Part 1: Provision the Backend Infrastructure
Terraform needs the S3 bucket and DynamoDB table to already exist before it can store state in them.
```bash
cd backend_infra
terraform init
terraform apply
```
Copy down the generated `s3_bucket_name` and `dynamodb_table_name` from the output.

### Part 2: Connect the Workload to Remote State
1. Open [`Day-4/main.tf`](./main.tf) and replace the bucket and dynamodb_table names with your values from Part 1.
2. Initialize the backend:
   ```bash
   cd ..
   terraform init
   ```
   *Terraform outputs: "Successfully configured the backend 's3'!"*
3. Apply:
   ```bash
   terraform apply
   ```
4. Verify on AWS: Open the S3 console, view the `.tfstate` object, and view the lock entries in DynamoDB while `terraform apply` is running!

---

## 🛠️ Essential State Management Commands
```bash
terraform state list           # Inspect all tracked resources
terraform state show <res>     # Show details of a specific resource
terraform state pull           # Stream remote state JSON to terminal
```
