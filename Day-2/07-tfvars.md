# 07 - Terraform `.tfvars` Files

## 1. What is a `.tfvars` File?

A `.tfvars` (Terraform Variables) file **supplies concrete values** for the input variables declared in your Terraform project.

Think of the separation of responsibilities:

```text
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│    main.tf      │       │  variables.tf   │       │   dev.tfvars    │
│                 │       │                 │       │                 │
│  WHAT to create │       │  WHAT inputs    │       │  WHAT VALUES    │
│  (Resources)    │       │  are accepted   │       │  to assign      │
└─────────────────┘       └─────────────────┘       └─────────────────┘
```

> **Memory Rule:**
> - `variables.tf` = **Declares** what variables exist.
> - `main.tf` = **Consumes** the variables (`var.name`).
> - `.tfvars` = **Assigns** actual values to those variables.

---

## 2. Standard Project Structure

```text
terraform-project/
├── main.tf          # Resource definitions
├── variables.tf     # Variable declarations & type definitions
├── dev.tfvars       # Values for Development
└── prod.tfvars      # Values for Production
```

---

## 3. Step-by-Step Implementation

### Step 1: Declare the variable in `variables.tf`
```hcl
variable "instance_type" {
  description = "The size of the EC2 instance"
  type        = string
}

variable "environment" {
  description = "Target deployment environment"
  type        = string
}
```

### Step 2: Reference the variable in `main.tf`
```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec" # Replace with valid AMI
  instance_type = var.instance_type       # <--- Reads from variable

  tags = {
    Name        = "${var.environment}-web-server"
    Environment = var.environment
  }
}
```

### Step 3: Assign values in `.tfvars` files
Notice that `.tfvars` files use simple `key = value` syntax (no `variable` keyword needed):

**`dev.tfvars`**:
```hcl
instance_type = "t2.micro"
environment   = "development"
```

**`prod.tfvars`**:
```hcl
instance_type = "t3.large"
environment   = "production"
```

---

## 4. Why Use `.tfvars` Files? (Multi-Environment Management)

Instead of duplicating your Terraform resource definitions for every environment, **your `.tf` code stays 100% identical**. 

You only swap the variable file:

```text
                          Same main.tf Code
                                  │
                 ┌────────────────┴────────────────┐
                 ↓                                 ↓
        Load dev.tfvars                    Load prod.tfvars
                 ↓                                 ↓
         t2.micro instance                 t3.large instance
         (Low cost for dev)                (High capacity for prod)
```

---

## 5. How to Execute with `-var-file`

You do not run `.tf` or `.tfvars` files directly. You execute Terraform CLI commands and instruct Terraform which `.tfvars` file to apply:

### For Development:
```bash
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

### For Production:
```bash
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

---

## 6. Automatic vs. Explicit Loading

Terraform handles variable files differently based on their naming:

### 1. Automatically Loaded (No flag needed)
If a file has one of the following exact names, Terraform loads it **automatically** during any `plan` or `apply`:
- `terraform.tfvars`
- `terraform.tfvars.json`
- Any file ending in `*.auto.tfvars` (e.g., `networking.auto.tfvars`)
- Any file ending in `*.auto.tfvars.json`

```bash
# Automatically picks up terraform.tfvars without extra flags:
terraform plan
```

### 2. Explicitly Loaded (Requires `-var-file`)
Any custom-named variable file (such as `dev.tfvars`, `staging.tfvars`, `prod.tfvars`) must be passed explicitly:
```bash
terraform plan -var-file="dev.tfvars"
```

---

## 7. Variable Definition Precedence (Which Value Wins?)

If a variable is defined in multiple places, Terraform resolves the value using this strict priority order (from lowest to highest):

```text
1. Default value in variable block (Lowest priority)
2. Environment variables (TF_VAR_name)
3. terraform.tfvars file
4. terraform.tfvars.json file
5. *.auto.tfvars or *.auto.tfvars.json (alphabetical order)
6. -var or -var-file flags passed in CLI (Highest priority - wins!)
```

---

## 8. Security Warning: Git & Sensitive Values

- **Never commit production `.tfvars` containing secrets** (e.g., database passwords, API keys) to version control.
- Keep `*.tfvars` in your [`.gitignore`](../.gitignore).
- Instead, commit a template file named **`terraform.tfvars.example`** with placeholder values so teammates know what variables to configure:

```hcl
# terraform.tfvars.example
instance_type = "t2.micro"
db_password   = "REPLACE_ME_LOCALLY"
```

---

## ⭐ Quick Revision Cheat Sheet

```text
┌──────────────────────────────┬────────────────────────────────────────────────────────┐
│ Concept                      │ Description                                            │
├──────────────────────────────┼────────────────────────────────────────────────────────┤
│ variables.tf                 │ Declares the variables (types, descriptions)           │
│ main.tf                      │ Uses the variables via var.<name>                      │
│ .tfvars                      │ Supplies the actual values (key = value)               │
│ terraform.tfvars             │ Automatically loaded by Terraform                      │
│ *.auto.tfvars                │ Automatically loaded by Terraform                      │
│ dev.tfvars / prod.tfvars     │ Loaded explicitly via -var-file="<file>"               │
│ -var-file="..."              │ CLI flag to specify custom variable file               │
└──────────────────────────────┴────────────────────────────────────────────────────────┘
```

### One-Line Takeaway:
> **`variables.tf` declares the inputs; `.tfvars` assigns their environment-specific values.**
