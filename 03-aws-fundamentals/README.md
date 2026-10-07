# Lab 03: AWS Fundamentals (Secure S3 Bucket)

## 🎯 Objectives
- Configure the `hashicorp/aws` provider
- Deploy an AWS S3 bucket with industry-standard security defaults:
  - Global unique naming using `random_id`
  - Bucket Versioning enabled
  - Server-Side Encryption (AES256 SSE-S3)
  - Public Access Blocked by default
- Manage resources via AWS CLI credentials

## 📋 Prerequisites
Ensure AWS CLI is configured with valid credentials:
```bash
aws configure
# Verify authentication:
aws sts get-caller-identity
```

## 📂 Files Overview
- `main.tf`: AWS provider, S3 bucket, versioning, encryption, and public access block.
- `variables.tf`: AWS region, bucket prefix, and environment tags.
- `outputs.tf`: Bucket ARN, bucket domain name, and bucket name.
- `terraform.tfvars.example`: Example configuration values.

## 🚀 How to Run

1. **Copy example variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Initialize Provider**:
   ```bash
   terraform init
   ```

3. **Validate and Plan**:
   ```bash
   terraform validate
   terraform plan
   ```

4. **Apply to AWS**:
   ```bash
   terraform apply
   ```

5. **Verify in AWS CLI**:
   ```bash
   aws s3 ls
   ```

6. **Destroy when done (avoids AWS charges)**:
   ```bash
   terraform destroy -auto-approve
   ```
