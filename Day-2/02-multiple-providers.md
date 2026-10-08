# 02 - Multiple Providers in Terraform

## 1. What Does "Multiple Providers" Mean?

Terraform can use **more than one provider within a single project**.

For example, a single Terraform project can manage infrastructure across both **AWS** and **Azure** simultaneously.

```text
                 Terraform Project
                 /               \
                ↓                 ↓
         AWS Provider      Azure Provider
              ↓                   ↓
             AWS                Azure
              ↓                   ↓
             EC2            Resource Group
```

> **One Terraform Project → Multiple Providers → Multiple Platforms**

---

## 2. Why Use Multiple Providers?

In real-world companies, infrastructure is rarely limited to a single platform:

```text
AWS Infrastructure                  Azure Infrastructure
├── EC2 Instances                   ├── Virtual Machines
├── S3 Buckets                      ├── Storage Accounts
└── VPC Networking                  └── Virtual Networks
```

Instead of maintaining completely separate tools or projects, a single Terraform configuration can coordinate across both:

1. **Multi-Cloud Architecture**: Deploy web servers on AWS and data analytics workloads on Google Cloud.
2. **Cloud + SaaS Services**: Provision an AWS EC2 instance, and automatically create a GitHub repository or Datadog dashboard for monitoring.
3. **Disaster Recovery / Redundancy**: Store primary data in AWS S3 and automated backups in Azure Blob Storage.

---

## 3. Can We Use Only `provider` Blocks?

Yes! For learning the concept, declaring basic `provider` blocks is enough:

```hcl
provider "aws" {
  region = "us-east-1"
}

provider "azurerm" {
  features {}
}
```

Terraform automatically identifies each provider by name and maps incoming resources accordingly.

---

## 4. Best Practice: The `required_providers` Block

For production projects, it is recommended to explicitly declare dependencies using `required_providers`:

```hcl
terraform {
  required_providers {
    # AWS Provider Dependency
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    # Azure Provider Dependency
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
```

### Why use `required_providers`?
- **WHAT** provider plugin do I need?
- **WHERE** does it come from? (`hashicorp/aws`)
- **WHICH** version range is allowed? (`~> 5.0`)

---

## 5. `required_providers` vs `provider`

This is an important distinction to remember:

| Block | Role | Question Answered | Example |
|---|---|---|---|
| `required_providers` | **Dependency** | Which plugin & version do I need? | `source = "hashicorp/aws", version = "~> 5.0"` |
| `provider` | **Configuration** | How should Terraform configure that plugin? | `region = "us-east-1"` |

```text
required_providers  ──>  WHAT plugin and version do I need?
provider block      ──>  HOW do I configure it (region, settings)?
```

---

## 6. Complete Single-File Example (`main.tf`)

Here is how a multi-provider configuration looks in practice:

```hcl
# ==========================================
# 1. Terraform Dependencies
# ==========================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# ==========================================
# 2. AWS Provider Configuration
# ==========================================
provider "aws" {
  region = "us-east-1"
}

# ==========================================
# 3. Azure Provider Configuration
# ==========================================
provider "azurerm" {
  features {}
}

# ==========================================
# 4. AWS Resource
# ==========================================
resource "aws_instance" "example" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-AWS-Server"
  }
}

# ==========================================
# 5. Azure Resource
# ==========================================
resource "azurerm_resource_group" "example" {
  name     = "terraform-learning-rg"
  location = "East US"

  tags = {
    Name        = "Terraform-Azure-RG"
    Environment = "Learning"
  }
}
```

---

## 7. How Does Terraform Know Which Provider to Use?

Terraform maps each resource to its provider **automatically based on the resource prefix**:

```text
aws_instance              ──> starts with "aws_"     ──> Sent to AWS Provider
azurerm_resource_group    ──> starts with "azurerm_" ──> Sent to Azure Provider
google_compute_instance   ──> starts with "google_"  ──> Sent to Google Cloud Provider
```

```text
                     Terraform Core
                           │
             ┌─────────────┴─────────────┐
             ↓                           ↓
       AWS Provider                Azure Provider
             ↓                           ↓
          AWS API                     Azure API
             ↓                           ↓
      aws_instance (EC2)       azurerm_resource_group
```

---

## 8. What Happens During `terraform init`?

When you run:
```bash
terraform init
```

Terraform reads the `required_providers` block, sees that **two** providers are requested, and downloads both binaries:

```text
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws plugins...
- Finding hashicorp/azurerm plugins...
- Installing hashicorp/aws v5.x.x...
- Installing hashicorp/azurerm v3.x.x...

Terraform has been successfully initialized!
```

---

## 9. Security Note: Never Hardcode Credentials

Never store real cloud credentials directly in your `.tf` files:

❌ **Avoid:**
```hcl
provider "aws" {
  access_key = "AKIAIOSFODNN7EXAMPLE" # DANGEROUS!
  secret_key = "wJalrXUtnFEMI/K7MDENG"  # DANGEROUS!
}
```

✅ **Use standard authentication:**
- AWS: `aws configure` (or environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).
- Azure: `az login` (Azure CLI authentication).

---

## 10. Real-World Analogy (Multiple Delivery Apps)

```text
You                      = Terraform Core
UberEats (Provider 1)    = AWS Provider   ──> Pizza from Domino's (AWS EC2)
DoorDash (Provider 2)    = Azure Provider ──> Burger from Wendy's (Azure VM)
```

You place an order for pizza and a burger at the same time. 
Terraform coordinates the workflow, while each individual delivery app communicates with its specific restaurant.

---

## ⭐ Quick Revision

| Concept | Meaning |
|---|---|
| **Multiple Providers** | Managing multiple different platforms in one Terraform project |
| **AWS Provider** | Connects Terraform to the AWS API |
| **Azure Provider** | Connects Terraform to the Azure API |
| **Resource Prefix** | How Terraform identifies providers (`aws_`, `azurerm_`) |
| **`required_providers`** | Declares plugin source and version constraints |
| **`provider` block** | Configures runtime settings (region, options) |
| **`terraform init`** | Downloads plugins for all declared providers |

### Core Rule to Remember:
```text
One Project → Multiple Providers → Multiple Platforms
Provider = WHERE
Resource = WHAT
```
