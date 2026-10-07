# 📘 Day 3: Building Reusable Infrastructure with Modules

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Understand the DRY (Don't Repeat Yourself) principle in Terraform.
- Differentiate between **Root Module** and **Child Modules**.
- Create a custom reusable child module for EC2 instances.
- Pass input variables into child modules.
- Export child module outputs to the root caller.
- Learn about public modules from the [Terraform Registry](https://registry.terraform.io).

---

## 📂 Architecture
```text
Day-3/
├── main.tf                    # Root Module (calls child module)
├── variables.tf               # Root input variables
├── outputs.tf                 # Exports outputs from child module
└── modules/
    └── ec2_instance/          # Child Module
        ├── main.tf            # Provisions EC2 instance
        ├── variables.tf       # Child module inputs
        └── outputs.tf         # Child module outputs
```

---

## 🚀 How to Run

1. **Initialize Terraform** (Terraform indexes and copies local modules into `.terraform/modules`):
   ```bash
   terraform init
   ```

2. **Validate and Plan**:
   ```bash
   terraform validate
   terraform plan
   ```

3. **Apply Configuration**:
   ```bash
   terraform apply
   ```

4. **Verify Outputs**:
   ```bash
   terraform output
   ```

5. **Clean Up**:
   ```bash
   terraform destroy -auto-approve
   ```
