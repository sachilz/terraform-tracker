# Lab 05: Remote State & State Locking (S3 + DynamoDB)

## 🎯 Objectives
- Understand Terraform State (`.tfstate`) and why it should never be committed to Git
- Learn how remote backends enable team collaboration
- Implement **State Locking** with AWS DynamoDB to prevent concurrent modifications
- Understand the chicken-and-egg problem (bootstrapping the backend storage first)
- Master state inspection and management commands

## 📂 Architecture
```text
05-state-and-backends/
├── README.md
├── 01-bootstrap-backend/         # First step: creates the S3 Bucket & DynamoDB Table
│   ├── main.tf
│   └── outputs.tf
└── 02-using-remote-state/        # Second step: consumes the remote backend
    ├── main.tf
    └── terraform.tfvars.example
```

## 🚀 Step-by-Step Walkthrough

### Step 1: Bootstrap the Remote State Storage
Before you can configure an S3 backend, the S3 bucket and DynamoDB table must physically exist.
```bash
cd 01-bootstrap-backend
terraform init
terraform apply
```
Take note of the output values:
- `state_bucket_name`
- `lock_table_name`

### Step 2: Use the Remote Backend in Your Project
1. Navigate to `02-using-remote-state`:
   ```bash
   cd ../02-using-remote-state
   ```
2. Open `main.tf` and update the `backend "s3"` block with your bucket and table names from Step 1.
3. Initialize the backend:
   ```bash
   terraform init
   ```
   *Terraform will report: "Initializing the backend... Successfully configured the backend "s3"!"*
4. Apply changes:
   ```bash
   terraform apply
   ```
   Notice that no local `.tfstate` file is created—state is securely stored in AWS S3 and locked in DynamoDB!

## 🛠️ Essential State Management Commands

| Command | Description |
|---|---|
| `terraform state list` | List all resources recorded in current state |
| `terraform state show <resource>` | Inspect specific resource attributes in state |
| `terraform state pull` | Download remote state to standard output |
| `terraform state rm <resource>` | Remove resource from state without destroying real infrastructure |
| `terraform state mv <source> <dest>` | Rename or move a resource in state |
| `terraform force-unlock <LOCK_ID>` | Release stuck lock if a run was abruptly killed |

## 🧹 Clean Up (Order Matters!)
1. First, destroy the sample project:
   ```bash
   cd 02-using-remote-state
   terraform destroy -auto-approve
   ```
2. Then destroy the backend infrastructure:
   ```bash
   cd ../01-bootstrap-backend
   terraform destroy -auto-approve
   ```
