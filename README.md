# 🚀 Terraform Tracker & Learning Roadmap

Welcome to your hands-on **Terraform Learning & Practice Repository**. This workspace is structured as a step-by-step curriculum with ready-to-run labs—from zero-cost local experiments to production-grade cloud architectures on AWS.

---

## 🧭 Repository Structure

Each directory represents a self-contained learning module with working code and its own detailed guide:

| Module | Topic | Provider | Description |
|---|---|---|---|
| [`01-basics-local-provider/`](./01-basics-local-provider) | Core Workflow | `local`, `random` | `init`, `plan`, `apply`, `destroy` without cloud costs or credentials |
| [`02-variables-and-outputs/`](./02-variables-and-outputs) | Variables & Validation | `local` | Data types, validation blocks, `tfvars`, sensitive outputs |
| [`03-aws-fundamentals/`](./03-aws-fundamentals) | Cloud IaC | `aws` | Secure S3 bucket with versioning, encryption, and public access blocks |
| [`04-modules/`](./04-modules) | Modular Architecture | `aws` | Reusable child modules (static website) and DRY code design |
| [`05-state-and-backends/`](./05-state-and-backends) | State & Collaboration | `aws` (S3 + DynamoDB) | Remote backend storage, state locking, and state CLI commands |
| [`06-environments-and-workspaces/`](./06-environments-and-workspaces) | Multi-Tenancy | `local` | Terraform Workspaces vs Directory isolation for Dev/Staging/Prod |
| [`07-best-practices-and-tools/`](./07-best-practices-and-tools) | Production Readiness | Tooling | `terraform fmt`, TFLint, tfsec, Infracost, and CI/CD security |

👉 **Track your learning milestones in [`PROGRESS.md`](./PROGRESS.md)!**

---

## 🛠️ Prerequisites & Setup (Windows)

### 1. Install Terraform CLI
Open **PowerShell as Administrator** and install Terraform via Windows Package Manager:
```powershell
winget install HashiCorp.Terraform
```
*Alternatively, install via Chocolatey: `choco install terraform`*

Restart your terminal and verify:
```powershell
terraform -version
```

### 2. Configure AWS CLI (For Cloud Labs 03-05)
AWS CLI is already available on your system (`aws-cli/2.x`). Configure your IAM access keys:
```powershell
aws configure
# Enter your AWS Access Key ID, Secret Key, and default region (e.g. us-east-1)
```

Verify authentication:
```powershell
aws sts get-caller-identity
```

---

## ⚡ Daily Terraform Cheat Sheet

### Core Lifecycle
```bash
terraform init                  # Initialize directory & download providers
terraform fmt -recursive        # Format all code to standard HCL style
terraform validate              # Check syntax and configuration validity
terraform plan                  # Preview planned infrastructure changes
terraform apply                 # Apply changes to reach desired state
terraform apply -auto-approve   # Apply without interactive prompt
terraform destroy               # Tear down all resources managed by state
```

### Variables & Outputs
```bash
terraform plan -var="environment=prod"              # Pass variable via CLI
terraform plan -var-file="staging.tfvars"            # Use custom variables file
terraform output                                     # View all defined outputs
terraform output -json app_summary                  # Query output as JSON
```

### State Management
```bash
terraform state list                                 # List all tracked resources
terraform state show <resource_name>                 # Show resource attributes
terraform state mv <source> <destination>            # Move/rename resource in state
terraform state rm <resource_name>                   # Remove resource from state
```

### Workspaces
```bash
terraform workspace list                             # View all workspaces
terraform workspace new dev                          # Create and switch to workspace
terraform workspace select dev                       # Switch active workspace
terraform workspace show                             # Print current active workspace
```

---

## 🔒 Security Best Practices
- **Never commit state files**: State contains secrets in plaintext. State files (`*.tfstate`) are already protected in [`.gitignore`](./.gitignore).
- **Never commit production `.tfvars`**: Use `*.example.tfvars` templates for Git.
- **Lock provider versions**: Always pin provider versions using `~>` pessimistic operator in `required_providers`.
- **Enforce Least Privilege**: Run Terraform with an IAM role scoped specifically for the resources being managed.