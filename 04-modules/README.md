# Lab 04: Terraform Modules & DRY Architecture

## 🎯 Objectives
- Understand why and how to build reusable Terraform modules (Don't Repeat Yourself)
- Distinguish between **Root Modules** (calling code) and **Child Modules** (reusable blueprints)
- Pass inputs into child modules and consume their outputs
- Instantiate multiple instances of the same module with different configurations

## 📂 Architecture
```text
04-modules/
├── main.tf                    # Root module: invokes child modules
├── variables.tf               # Root input variables
├── outputs.tf                 # Exports outputs returned from modules
└── modules/
    └── s3_website/            # Reusable child module
        ├── main.tf            # S3 bucket, website config, object upload
        ├── variables.tf       # Child module inputs
        ├── outputs.tf         # Child module outputs
        └── assets/
            └── index.html     # HTML template uploaded by module
```

## 🚀 How to Run

1. **Initialize Terraform** (installs child modules into `.terraform/modules`):
   ```bash
   terraform init
   ```

2. **Validate and Plan**:
   ```bash
   terraform validate
   terraform plan
   ```

3. **Apply**:
   ```bash
   terraform apply
   ```

4. **Test Output URL**:
   Inspect the website endpoint output generated from the module!

5. **Clean Up**:
   ```bash
   terraform destroy -auto-approve
   ```
