# 📊 Terraform Learning Progress Tracker

Use this checklist to track your learning journey from fundamentals to production-grade Infrastructure as Code (IaC). Mark items as completed by changing `[ ]` to `[x]`.

---

## 🟢 Level 1: Foundations & Core Concepts
- [ ] Understand Infrastructure as Code (IaC) principles & declarative vs imperative
- [ ] Install Terraform CLI & verify installation (`terraform -version`)
- [ ] Understand HCL (HashiCorp Configuration Language) syntax and blocks
- [ ] Master the 4 core workflow steps:
  - [ ] `terraform init` (providers, backend, modules)
  - [ ] `terraform plan` (dry run / execution preview)
  - [ ] `terraform apply` (provisioning infrastructure)
  - [ ] `terraform destroy` (tearing down resources)
- [ ] Understand `.terraform` folder and the dependency lock file (`.terraform.lock.hcl`)
- [ ] Run zero-cost local labs using `hashicorp/local` and `hashicorp/random`

---

## 🟡 Level 2: Variables, Outputs & Expressions
- [ ] Declare and use input variables (`string`, `number`, `bool`)
- [ ] Use complex variable types (`list`, `map`, `object`)
- [ ] Write custom variable validation rules (`validation` block)
- [ ] Understand variable precedence (CLI `-var`, `terraform.tfvars`, `*.auto.tfvars`, environment variables `TF_VAR_*`)
- [ ] Define and query `output` values
- [ ] Protect sensitive information using `sensitive = true`
- [ ] Master HCL functions (`jsonencode`, `lookup`, `contains`, `length`, `format`, `timestamp`)

---

## 🟠 Level 3: Cloud Provisioning with AWS
- [ ] Configure AWS CLI with IAM credentials (`aws configure`)
- [ ] Understand Terraform AWS Provider and provider configurations
- [ ] Provision AWS S3 bucket with secure defaults:
  - [ ] S3 Bucket Versioning
  - [ ] S3 Server-Side Encryption (SSE-S3 / KMS)
  - [ ] S3 Public Access Block
- [ ] Apply resource tagging strategies (`default_tags`)
- [ ] Provision network resources (VPC, Subnets, Internet Gateway, Route Tables)
- [ ] Provision compute resources (EC2 instances, Security Groups, Key Pairs)

---

## 🔵 Level 4: Reusable Modules & Architecture
- [ ] Understand Root Module vs Child Module
- [ ] Build a reusable child module from scratch
- [ ] Pass inputs and expose outputs across modules
- [ ] Instantiate multiple environments using the same module
- [ ] Leverage verified modules from the official Terraform Registry
- [ ] Understand module versioning and source types (local paths, Git repos, registry)

---

## 🟣 Level 5: State Management & Backends
- [ ] Deep dive into `terraform.tfstate` structure
- [ ] Understand why state must never be stored in version control
- [ ] Set up Remote State backend in AWS S3
- [ ] Enable State Locking with AWS DynamoDB
- [ ] Practice state migration from local to remote backend
- [ ] Execute state management commands:
  - [ ] `terraform state list`
  - [ ] `terraform state show`
  - [ ] `terraform state mv`
  - [ ] `terraform state rm`
  - [ ] `terraform refresh`
  - [ ] `terraform force-unlock`

---

## 🔴 Level 6: Advanced Multi-Environment & Lifecycle
- [ ] Compare Terraform Workspaces vs Directory-based isolation
- [ ] Create and toggle workspaces (`terraform workspace new`, `select`)
- [ ] Implement resource lifecycle meta-arguments:
  - [ ] `create_before_destroy`
  - [ ] `prevent_destroy`
  - [ ] `ignore_changes`
- [ ] Use meta-arguments:
  - [ ] `count`
  - [ ] `for_each`
  - [ ] `depends_on`
- [ ] Master Terraform Data Sources to reference existing infrastructure

---

## 🛡️ Level 7: Production Best Practices & Security
- [ ] Enforce automated formatting with `terraform fmt -recursive`
- [ ] Code validation with `terraform validate`
- [ ] Static analysis & linting with **TFLint**
- [ ] Infrastructure security scanning with **tfsec** or **Checkov**
- [ ] Cost estimation with **Infracost**
- [ ] Setup pre-commit hooks to block secrets and bad formatting
- [ ] Build a CI/CD pipeline (GitHub Actions / GitLab CI) for Terraform Plan & Apply
