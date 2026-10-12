# 04 - Terraform `required_providers`

## 1. What is `required_providers`?

The `required_providers` block lives inside the `terraform { ... }` block. 

It defines the **provider dependencies** for your project by telling Terraform:

1. **WHAT** provider plugins the project needs.
2. **WHERE** to find and download them (`source`).
3. **WHICH** versions are permitted (`version`).

```text
                  required_providers
                          │
          ┌───────────────┼───────────────┐
          ↓               ↓               ↓
     Local Name        Source          Version
       "aws"       "hashicorp/aws"     "~> 5.0"
```

---

## 2. Example Configuration

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    # AWS Provider Dependency
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    # Azure Provider Dependency
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0, < 4.0"
    }
  }
}
```

---

## 3. Understanding the Code Line-by-Line

### 1. `terraform { ... }`
The top-level configuration block that controls Terraform's own engine behavior and requirements.

### 2. `required_providers { ... }`
Nested inside `terraform {}`, this block contains the list of all external provider plugins this module relies upon.

### 3. Local Name (`aws`, `azurerm`)
The local name (e.g., `aws`) is the identifier you use throughout your `.tf` files to configure the provider and its resources.

### 4. `source`
Specifies the global address of the provider on the [Terraform Registry](https://registry.terraform.io):

```text
[hostname] / [namespace] / [type]
```

- **`hashicorp/aws`** is shorthand for:
  `registry.terraform.io/hashicorp/aws`
- **`hashicorp`** is the publisher (namespace).
- **`aws`** is the provider type.

Other examples:
- `hashicorp/google` (Google Cloud)
- `integrations/github` (GitHub)
- `cloudflare/cloudflare` (Cloudflare)

### 5. `version`
Specifies which versions of the provider plugin are acceptable to download and use.

---

## 4. Understanding Version Constraints

Terraform uses version constraints to prevent breaking changes when provider plugins are updated:

| Version Constraint | Meaning | Explanation |
|---|---|---|
| `"5.10.0"` | Exact Version | Only installs version `5.10.0` |
| `!= 5.10.0` | Exclude Version | Any version except `5.10.0` |
| `>= 5.0` | Greater or equal | Version `5.0.0` or newer |
| `< 6.0` | Less than | Any version strictly below `6.0.0` |
| `>= 5.0, < 6.0` | Combined constraint | Version `5.0.0` or newer, but strictly below `6.0.0` |
| `~> 5.0` **(Pessimistic)** | Minor range | Allows minor updates: `>= 5.0.0` and `< 6.0.0` |
| `~> 5.10.0` | Patch range | Allows only patch/bugfix updates: `>= 5.10.0` and `< 5.11.0` |

### 💡 Why is `~>` (Pessimistic Constraint) Recommended?
Semantic Versioning (SemVer) follows `MAJOR.MINOR.PATCH`:
- **MAJOR** updates (e.g., `5.x` -> `6.x`) can introduce **breaking syntax changes**.
- **MINOR** and **PATCH** updates add new features and bug fixes without breaking existing code.

Using `~> 5.0` allows you to receive automatic bug fixes and new AWS resources while preventing unexpected breaking changes!

---

## 5. `required_providers` vs. `provider` Block

These two blocks are often confused by beginners. Keep this simple rule in mind:

| Block | Role | Question Answered | Example |
|---|---|---|---|
| **`required_providers`** | Dependency Declaration | **WHAT plugin & version do I need?** | `source = "hashicorp/aws", version = "~> 5.0"` |
| **`provider`** | Runtime Configuration | **HOW do I configure that plugin?** | `region = "us-east-1"` |

```text
required_providers  ──>  Which plugin binary should Terraform download?
provider block      ──>  Which region, credentials, or settings should it use?
```

---

## 6. How It Works in Practice (`terraform init`)

```text
1. Write required_providers in main.tf
                  │
                  ▼
         Run: terraform init
                  │
                  ▼
     Terraform queries Registry API
                  │
                  ▼
    Downloads matching binary into:
       .terraform/providers/
                  │
                  ▼
     Generates or updates lock file:
         .terraform.lock.hcl
```

### The Lock File (`.terraform.lock.hcl`):
When `terraform init` runs, it creates `.terraform.lock.hcl`. 
- It records the **exact version** downloaded (e.g., `5.31.0`).
- It records cryptographic checksums (hashes) for Windows, macOS, and Linux.
- **Always commit this file to Git** to ensure that your teammates and CI/CD pipelines use the exact same provider version!

---

## ⭐ Quick Revision Cheat Sheet

```text
┌─────────────────────────┬────────────────────────────────────────────────────────┐
│ Concept                 │ Quick Summary                                          │
├─────────────────────────┼────────────────────────────────────────────────────────┤
│ required_providers      │ Declares required provider plugins, sources & versions │
│ source                  │ Location in registry (e.g., hashicorp/aws)             │
│ version                 │ SemVer constraint rule (e.g., ~> 5.0)                  │
│ provider block          │ Configures region, options, and aliases                │
│ terraform init          │ Reads required_providers and installs plugins          │
│ .terraform.lock.hcl     │ Locks exact versions and checksums across team         │
└─────────────────────────┴────────────────────────────────────────────────────────┘
```

### One-Line Takeaway:
> **`required_providers` declares the plugin dependency, while `provider` configures how that plugin runs.**
