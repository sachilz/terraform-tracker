# 📘 Day 7: Security, Secrets Management & HashiCorp Vault

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Understand the security risks of hardcoded credentials in Terraform configurations and state files.
- Integrate **HashiCorp Vault** or **AWS Secrets Manager** to fetch secrets dynamically at runtime.
- Use `sensitive = true` flags to prevent secrets from being printed in console logs or CI/CD pipelines.
- Run static security analysis with **tfsec** and **Checkov** to identify vulnerabilities before applying.

---

## 📂 Architecture
Rather than hardcoding database passwords, Terraform connects to HashiCorp Vault (or AWS Secrets Manager) via data sources:
```hcl
data "vault_generic_secret" "db_creds" {
  path = "secret/database"
}
```

---

## 🚀 Step-by-Step Hands-on

1. **Static Analysis with tfsec**:
   Scan your configuration for security antipatterns:
   ```bash
   tfsec .
   ```

2. **Initialize and Plan**:
   ```bash
   terraform init
   terraform plan
   ```

3. **Verify Sensitive Output Redaction**:
   Notice that running `terraform output` redacts any values marked `sensitive = true`:
   ```bash
   terraform apply
   terraform output
   # Returns: db_secret = <sensitive>
   ```

4. **Clean Up**:
   ```bash
   terraform destroy -auto-approve
   ```

---

## 🛡️ Security Golden Rules
1. **Never commit `.tfvars` containing real passwords**.
2. **Never commit `terraform.tfstate`**.
3. **Use remote state with server-side encryption enabled**.
4. **Use IAM least privilege** for CI/CD runners.
