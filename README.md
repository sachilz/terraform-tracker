# 🚀 Terraform Zero to Hero - Course Tracker & Practice Labs

Companion repository for **Abhishek Veeramalla's** [Terraform Zero to Hero YouTube Course](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf).

This repository contains organized, step-by-step code and notes for every single day in the course.

---

## 📅 Course Syllabus & Labs

| Day | Topic | Key Concepts | Lab Link |
|---|---|---|---|
| **Day 1** | Getting Started with Terraform | IaC, Core Architecture, First AWS EC2, `init`, `plan`, `apply`, `destroy` | [👉 Day-1](./Day-1/README.md) |
| **Day 2** | Terraform Providers & Configuration | Provider Architecture, `required_providers`, Aliases (`alias`), Authentication, Lock File | [👉 Day-2](./Day-2/README.md) |
| **Day 3** | Reusable Modules | Root vs Child Modules, DRY Architecture, Module Inputs/Outputs | [👉 Day-3](./Day-3/README.md) |
| **Day 4** | State Management & Remote Backend | `terraform.tfstate`, S3 Remote Backend, DynamoDB State Locking | [👉 Day-4](./Day-4/README.md) |
| **Day 5** | Provisioners & Connection Blocks | `remote-exec`, `local-exec`, SSH Keys, and why `user_data` is preferred | [👉 Day-5](./Day-5/README.md) |
| **Day 6** | Managing Environments with Workspaces | CLI Workspaces (`dev`, `stage`, `prod`), `terraform.workspace` lookups | [👉 Day-6](./Day-6/README.md) |
| **Day 7** | Security & Secrets Management | AWS Secrets Manager, Sensitive Variables, `tfsec` static scanning | [👉 Day-7](./Day-7/README.md) |
| **Day 8** | Real-World Capstone Project | Full VPC, Subnets, Internet Gateway, Security Groups & Automated Nginx | [👉 Day-8](./Day-8/README.md) |

👉 **Track your learning milestones in [PROGRESS.md](./PROGRESS.md)!**

---

## 🛠️ Setup Instructions (Windows)

### 1. Install Terraform CLI
Run in **PowerShell (Run as Administrator)**:
```powershell
winget install HashiCorp.Terraform
```
Restart your PowerShell window and verify:
```powershell
terraform -version
```

### 2. Configure AWS CLI
Configure your IAM credentials:
```powershell
aws configure
```
Verify authentication:
```powershell
aws sts get-caller-identity
```

---

## ⚡ Daily Terraform Commands Cheat Sheet

```bash
# Core workflow
terraform init                  # Download providers and configure backends
terraform fmt -recursive        # Auto-format all .tf code
terraform validate              # Verify configuration syntax
terraform plan                  # Preview pending changes
terraform apply                 # Apply changes to cloud
terraform destroy               # Tear down all resources

# State Management
terraform state list            # List resources recorded in state
terraform state show <res>      # Inspect specific resource details
terraform state pull            # Read remote state file

# Workspaces
terraform workspace list        # Show all workspaces
terraform workspace new dev     # Create and switch to workspace 'dev'
terraform workspace select dev  # Switch active workspace
```
