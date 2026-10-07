# Lab 06: Environments & Multi-Tenancy

## 🎯 Objectives
- Understand the two predominant strategies for multi-environment infrastructure:
  1. **Terraform Workspaces** (CLI-level environment switching)
  2. **Directory Isolation** (Folder per environment: `dev/`, `staging/`, `prod/`)
- Understand pros and cons of each approach
- Implement workspace-driven configuration using `terraform.workspace`

---

## Strategy A: Terraform Workspaces (Single Codebase)

Terraform Workspaces allow you to use a single directory of `.tf` files with isolated state files for each workspace (`default`, `dev`, `prod`).

### Files:
- `workspace-approach/main.tf`

### Workspace Commands:
```bash
cd workspace-approach

# List existing workspaces
terraform workspace list

# Create and switch to 'dev'
terraform workspace new dev

# Plan and apply for 'dev'
terraform apply

# Switch to 'prod'
terraform workspace new prod
terraform apply

# View current active workspace
terraform workspace show
```

Inside `main.tf`, you can interpolate `${terraform.workspace}` to vary sizing, names, or tags:
```hcl
locals {
  instance_type = terraform.workspace == "prod" ? "t3.medium" : "t3.micro"
}
```

---

## Strategy B: Directory Isolation (Production Best Practice)

For enterprise production systems, **directory isolation** is generally preferred because:
- Different environments can run different module versions.
- Access permissions (IAM/RBAC) can be scoped per directory/repo branch.
- A change to `dev` has zero risk of destroying `prod` due to accidental CLI workspace context mistakes.

### Directory Structure:
```text
directory-approach/
├── modules/
│   └── service/          # Shared service module
├── environments/
│   ├── dev/
│   │   ├── main.tf       # calls service module (version/replica = dev)
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf       # calls service module (version/replica = prod)
│       └── terraform.tfvars
```
