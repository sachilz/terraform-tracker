# Lab 01: Terraform Fundamentals (Local Provider)

## 🎯 Objectives
- Understand Terraform core workflow: `init` -> `plan` -> `apply` -> `destroy`
- Work with providers (`local`, `random`) without requiring any cloud credentials or incurring costs
- Understand the `terraform.lock.hcl` and `.terraform` directory

## 📂 Files Overview
- `main.tf`: Declares providers and creates local files with randomized content.
- `outputs.tf`: Exports file paths and generated values to the terminal.

## 🚀 How to Run

1. **Initialize Terraform** (downloads required provider plugins):
   ```bash
   terraform init
   ```

2. **Format and Validate**:
   ```bash
   terraform fmt
   terraform validate
   ```

3. **Preview Changes**:
   ```bash
   terraform plan
   ```

4. **Apply Configuration**:
   ```bash
   terraform apply
   # Type 'yes' when prompted (or pass -auto-approve)
   ```

5. **Inspect the State**:
   ```bash
   terraform show
   terraform state list
   ```

6. **Clean Up**:
   ```bash
   terraform destroy
   ```

## 💡 Key Takeaways
- **Idempotence**: Running `terraform apply` twice without changing code will result in "No changes".
- **State File**: Notice `terraform.tfstate` is generated. It maps your configuration to real-world resources.
