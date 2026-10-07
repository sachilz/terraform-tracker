# Lab 07: Terraform Best Practices, Linting & Security

## 🎯 Objectives
- Enforce code formatting and consistency across the team
- Run static analysis with **TFLint**
- Scan for security vulnerabilities and misconfigurations using **tfsec** / **Checkov**
- Estimate cloud costs before merging pull requests with **Infracost**
- Integrate pre-commit hooks to safeguard against common mistakes

---

## 1. Native CLI Best Practices

### Formatting
Always format your configuration before committing:
```bash
# Formats all .tf files in current folder and all subfolders
terraform fmt -recursive
# Check if files need formatting without changing them (CI/CD check)
terraform fmt -check
```

### Validation
Verify syntactical validity and internal consistency:
```bash
terraform validate
```

---

## 2. Static Analysis & Linting (TFLint)

[TFLint](https://github.com/terraform-linters/tflint) catches provider-specific issues, deprecated syntax, and unused declarations.

```bash
# Installation via winget (Windows):
winget install Terraform-Linters.tflint

# Initialize plugins and run
tflint --init
tflint
```

Example `.tflint.hcl` configuration:
```hcl
plugin "aws" {
  enabled = true
  version = "0.32.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_resource_missing_tags" {
  enabled = true
  tags    = ["Environment", "ManagedBy"]
}
```

---

## 3. Security Scanning (tfsec / Checkov)

[tfsec](https://github.com/aquasecurity/tfsec) scans code for security antipatterns before any infrastructure is provisioned (e.g., open security groups, unencrypted S3 buckets, exposed databases).

```bash
# Install tfsec via winget:
winget install aqua-security.tfsec

# Scan directory:
tfsec .
```

---

## 4. Cost Estimation (Infracost)

[Infracost](https://www.infracost.io/) shows cloud cost estimates directly from your Terraform code:
```bash
infracost breakdown --path .
```

---

## 5. Security Golden Rules
1. **Never commit `.tfstate`**: State files often contain raw database passwords and secret keys.
2. **Never commit `.tfvars` containing secrets**: Keep secrets in AWS Secrets Manager, AWS SSM Parameter Store, or inject them via environment variables (`TF_VAR_db_password="secret"`).
3. **Always pin provider versions**: Use `~>` pessimistic constraints (e.g. `~> 5.0`) to avoid unexpected breaking changes.
4. **Always enable S3 Bucket Encryption & Versioning**.
5. **Always block public access by default** unless specifically serving a public website.
