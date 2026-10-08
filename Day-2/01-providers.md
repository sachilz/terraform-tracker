# 01 - Terraform Providers

## 1. What is a Provider?

Think of Terraform as a **manager**.

Terraform Core understands HCL code and builds the execution plan, but it **does not know how to talk directly to AWS, Azure, GCP, Kubernetes, etc.**

A **Provider is a plugin** that acts as a translator or connector between Terraform and a target platform.

```text
Terraform Core
      ↓
   Provider  (Plugin / Translator)
      ↓
AWS / Azure / GCP / Kubernetes
```

---

## 2. What is an API?

An **API (Application Programming Interface)** allows two different systems to communicate.

Every cloud platform provides an API. When you create an EC2 instance in the AWS Console, AWS internally calls its API.

When using Terraform:
```text
Terraform Code → AWS Provider → AWS API → EC2 Instance
```

The provider translates your declarative Terraform code into actual API requests (HTTP `POST`, `GET`, etc.) that the target platform understands.

---

## 3. How Do We Define a Provider?

A provider is defined using a `provider` block:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

This tells Terraform:
> *"I want to work with AWS, and my target region is `us-east-1`."*

---

## 4. Provider vs Resource (The Core Rule)

This is the most important fundamental distinction in Terraform:

```text
Provider = WHERE  (Which platform to connect to)
Resource = WHAT   (What infrastructure object to create)
```

### Example:

```hcl
# WHERE to create:
provider "aws" {
  region = "us-east-1"
}

# WHAT to create:
resource "aws_instance" "example" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
}
```

### Comparison Across Platforms:

| Provider (WHERE) | Resource (WHAT) |
|---|---|
| `aws` | `aws_instance`, `aws_s3_bucket`, `aws_vpc` |
| `azurerm` | `azurerm_linux_virtual_machine`, `azurerm_virtual_network` |
| `google` | `google_compute_instance`, `google_storage_bucket` |
| `kubernetes` | `kubernetes_pod`, `kubernetes_service` |

---

## 5. Real-World Analogy (Food Delivery)

Think about ordering food:

```text
You                     = Terraform Core
Delivery App (UberEats) = Provider
Restaurant              = Cloud Platform (AWS)
Food Item               = Cloud Resource (EC2)
```

1. **You (Terraform)** specify what you want: *"I want an EC2 instance"*.
2. You don't build the server or call AWS hardware directly.
3. The **Delivery App (Provider)** takes your order and communicates with the **Restaurant (AWS API)**.
4. The Restaurant creates the resource.
5. The Provider confirms back to you: *"Resource created!"*

---

## 6. Summary

```text
┌────────────────────────────────────────────────────────┐
│                      KEY TAKEAWAY                      │
├────────────────────────────────────────────────────────┤
│ • Terraform Core does not talk to clouds directly.     │
│ • Providers are plugins that communicate with APIs.    │
│ • Provider = WHERE (AWS, Azure, GCP)                   │
│ • Resource = WHAT (EC2, S3, VM)                        │
└────────────────────────────────────────────────────────┘
```
