# 📘 Day 1: Getting Started with Terraform

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Understand what Infrastructure as Code (IaC) is and why Terraform is used.
- Understand the Terraform Core architecture (Terraform Core vs Providers).
- Install Terraform and configure AWS credentials.
- Master the 4 core lifecycle commands:
  - `terraform init`
  - `terraform plan`
  - `terraform apply`
  - `terraform destroy`
- Provision your very first EC2 instance on AWS.
- Inspect the generated `terraform.tfstate` file.

---

## 📋 Prerequisites
1. **AWS CLI Configured**:
   ```bash
   aws configure
   # Verify credentials:
   aws sts get-caller-identity
   ```

2. **Terraform CLI Installed**:
   ```bash
   terraform -version
   ```

---

## 📂 Code Files
- [`main.tf`](./main.tf): Defines the AWS provider and creates a basic `t2.micro` EC2 instance.
- [`outputs.tf`](./outputs.tf): Prints the Public IP, Instance ID, and Instance Name to the console.
- [`QNA.md`](./QNA.md): Frequently asked questions, common errors, and simple explanations.

---

## 🚀 Step-by-Step Hands-on

1. **Initialize Terraform**:
   Downloads the required AWS provider plugin into `.terraform/`.
   ```bash
   terraform init
   ```

2. **Format and Validate**:
   ```bash
   terraform fmt
   terraform validate
   ```

3. **Generate Execution Plan**:
   Review what resources Terraform will create before executing:
   ```bash
   terraform plan
   ```

4. **Apply Configuration**:
   Provision the real EC2 instance on AWS:
   ```bash
   terraform apply
   # Type 'yes' when prompted
   ```

5. **Verify**:
   Check your AWS EC2 Console or run:
   ```bash
   aws ec2 describe-instances
   ```

6. **Destroy (Clean Up)**:
   Avoid unwanted AWS billing by tearing down resources after learning:
   ```bash
   terraform destroy
   ```

---

## 💡 Key Takeaways
- **Declarative Approach**: You declare *what* infrastructure you want, Terraform figures out *how* to achieve it.
- **Idempotence**: Running `terraform apply` multiple times without changing code results in 0 changes.
