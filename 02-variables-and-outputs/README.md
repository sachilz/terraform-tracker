# Lab 02: Variables, Types, and Outputs

## 🎯 Objectives
- Master Terraform input variable types (`string`, `number`, `bool`, `list`, `map`, `object`)
- Implement variable validation rules (`validation` blocks)
- Use `terraform.tfvars` to customize parameters per deployment
- Work with sensitive variables to avoid leaking credentials in console output
- Define structured and formatted outputs

## 📂 Files Overview
- `variables.tf`: All variable declarations, type constraints, descriptions, and validations.
- `terraform.tfvars.example`: Example values to copy into your own `terraform.tfvars`.
- `main.tf`: Uses variables to generate configuration files and mock resources.
- `outputs.tf`: Exports structured values from state.

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

3. **Try Overriding Variables via CLI**:
   ```bash
   terraform plan -var="environment=prod" -var="app_port=8080"
   ```

4. **Apply and Observe Outputs**:
   ```bash
   terraform apply -auto-approve
   ```

5. **View Outputs Anytime**:
   ```bash
   terraform output
   terraform output -json app_summary
   ```

6. **Clean Up**:
   ```bash
   terraform destroy -auto-approve
   ```
