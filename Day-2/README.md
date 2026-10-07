# 📘 Day 2: Advanced Terraform Configuration (Variables, Data Sources & Functions)

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Decouple hardcoded values using Input Variables (`variables.tf`).
- Explore Variable Data Types (`string`, `number`, `list`, `map`, `object`).
- Dynamic lookup using **Data Sources** (fetch the latest official Ubuntu AMI automatically without hardcoding AMI IDs).
- Use **Conditional Expressions** (ternary logic `condition ? true_val : false_val`).
- Master HCL **Built-in Functions** (`lookup`, `element`, `length`, `format`).
- Export important outputs (`outputs.tf`).
- Use `terraform.tfvars` for environment configuration.

---

## 📂 Files Overview
- [`variables.tf`](./variables.tf): Declarations of input variables with defaults and descriptions.
- [`main.tf`](./main.tf): Dynamic EC2 configuration querying AMI via `data "aws_ami"` and applying conditions.
- [`outputs.tf`](./outputs.tf): Structured outputs including public IP and instance state.
- [`terraform.tfvars.example`](./terraform.tfvars.example): Template for custom parameter values.

---

## 🚀 How to Run

1. **Copy example variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Initialize and Plan**:
   ```bash
   terraform init
   terraform plan
   ```

3. **Override variable on the fly**:
   ```bash
   terraform plan -var="instance_type=t3.micro"
   ```

4. **Apply**:
   ```bash
   terraform apply
   ```

5. **Query Outputs**:
   ```bash
   terraform output
   terraform output -raw instance_public_ip
   ```

6. **Destroy**:
   ```bash
   terraform destroy -auto-approve
   ```
