# 03 - Multiple Regions in Terraform

## 1. What Does "Multiple Regions" Mean?

In Terraform, you can deploy and manage infrastructure across **multiple regions of the same cloud provider** (e.g., AWS) within a single project.

For example, from one Terraform configuration, you can launch:
- An EC2 instance in **`us-east-1`** (N. Virginia)
- An EC2 instance in **`us-west-2`** (Oregon)

```text
                     Terraform Project
                             │
                        AWS Provider
                       /            \
                      ↓              ↓
                  us-east-1      us-west-2
                      ↓              ↓
                  EC2 Server     EC2 Server
```

---

## 2. Why Do We Need Multiple Provider Configurations?

Normally, an AWS provider block defines a single region:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

Any AWS resource you define will automatically be created in `us-east-1`.

If you also want resources in `us-west-2`, you must declare a **second AWS provider block**. But because both blocks configure the **same provider (`aws`)**, Terraform needs a way to tell them apart.

👉 **This is where `alias` comes in.**

---

## 3. What is `alias`?

The `alias` argument gives a provider configuration a **unique name / identifier**.

```hcl
# Default Provider (us-east-1)
provider "aws" {
  region = "us-east-1"
}

# Secondary Provider with an alias (us-west-2)
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
```

Now you have two AWS configurations available:
1. **Default AWS Provider**: Targets `us-east-1` (used automatically if no provider is specified).
2. **`aws.west`**: Targets `us-west-2` (used when explicitly referenced).

*(Note: You can also alias both as `alias = "us-east-1"` and `alias = "us-west-2"`)*.

---

## 4. How Does a Resource Choose Its Region?

Inside any resource block, use the **`provider`** meta-argument to point to the aliased provider:

```hcl
# 1. This resource uses the default provider (us-east-1)
resource "aws_instance" "east_server" {
  ami           = "ami-0c7217cdde317cfec" # Valid in us-east-1
  instance_type = "t2.micro"

  tags = {
    Name = "East-Coast-Server"
  }
}

# 2. This resource explicitly selects the aliased provider (us-west-2)
resource "aws_instance" "west_server" {
  provider      = aws.west # <--- Reference: <provider>.<alias>
  ami           = "ami-08e4e35cccc6189f4" # Valid in us-west-2
  instance_type = "t2.micro"

  tags = {
    Name = "West-Coast-Server"
  }
}
```

### Visual Routing:
```text
aws_instance.east_server  ──> (No provider set) ──> Default AWS Provider ──> us-east-1
aws_instance.west_server  ──> provider = aws.west ──> Aliased Provider ───> us-west-2
```

---

## 5. Complete Working Example (`main.tf`)

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==========================================
# 1. Primary Region Provider (US East)
# ==========================================
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

# ==========================================
# 2. Disaster Recovery / Secondary Region (US West)
# ==========================================
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

# ==========================================
# 3. Resources Deployed in US East
# ==========================================
resource "aws_instance" "primary_app" {
  provider      = aws.east
  ami           = "ami-0c7217cdde317cfec" # Update with valid us-east-1 AMI
  instance_type = "t2.micro"

  tags = {
    Name = "Primary-Application-East"
  }
}

# ==========================================
# 4. Resources Deployed in US West
# ==========================================
resource "aws_instance" "secondary_app" {
  provider      = aws.west
  ami           = "ami-08e4e35cccc6189f4" # Update with valid us-west-2 AMI
  instance_type = "t2.micro"

  tags = {
    Name = "DR-Application-West"
  }
}
```

---

## 6. ⚠️ Critical Gotcha: AMIs Are Region-Specific!

A very common mistake when deploying to multiple AWS regions is copying the same AMI ID.

> **AMIs are bound to a specific region.**
> 
> An AMI ID (e.g., `ami-0c7217cdde317cfec`) that exists in `us-east-1` **does NOT exist** in `us-west-2`.
> 
> If you reuse the east AMI ID in the west provider, Terraform will throw an error: `InvalidAMIID.NotFound`.

Always make sure you use an AMI ID that is valid for the specific region, or look it up dynamically using data sources.

---

## 7. Multiple Providers vs. Multiple Regions

These two concepts are related but solve different problems:

| Concept | What It Means | Solution in Terraform | Example |
|---|---|---|---|
| **Multiple Providers** | Different platforms | Different provider blocks (`aws`, `azurerm`, `github`) | AWS EC2 + Azure VM |
| **Multiple Regions** | Same platform, different geographical locations | Multiple configurations of the *same* provider using **`alias`** | AWS `us-east-1` + AWS `us-west-2` |

```text
Multiple Providers  ──>  Different Clouds / Platforms
Multiple Regions    ──>  Same Cloud, Different Locations (uses alias)
```

---

## 8. Real-World Use Cases for Multiple Regions

1. **Disaster Recovery (DR) & High Availability**: Deploying active-passive or active-active workloads across two distinct regions.
2. **Global Latency Optimization**: Deploying web servers closer to users in different continents (e.g., `us-east-1` for US users and `eu-west-1` for European users).
3. **Cross-Region Replication**: Creating an S3 bucket in Region A and configuring replication to a backup bucket in Region B.

---

## 9. Terraform Workflow

```bash
# 1. Initialize (downloads AWS plugin once, used by both regions)
terraform init

# 2. Check syntax
terraform validate

# 3. Preview multi-region execution plan
terraform plan

# 4. Deploy resources to both regions simultaneously
terraform apply

# 5. Clean up
terraform destroy
```

---

## ⭐ Quick Revision Cheat Sheet

```text
┌─────────────────────────┬────────────────────────────────────────────────────────┐
│ Concept                 │ Quick Summary                                          │
├─────────────────────────┼────────────────────────────────────────────────────────┤
│ Multiple Regions        │ Same cloud platform across different regions           │
│ alias                   │ Gives a provider configuration a unique identifier     │
│ aws.<alias>             │ How you reference the aliased provider in code         │
│ provider = aws.<alias>  │ Tells a specific resource which region to deploy into  │
│ AMI Rule                │ AMIs are region-specific; never reuse the same AMI ID  │
└─────────────────────────┴────────────────────────────────────────────────────────┘
```

### Memory Trick:
- **`alias`** = Give each regional provider configuration a name.
- **`provider = aws.<alias>`** = Tell the resource which configuration to use.
