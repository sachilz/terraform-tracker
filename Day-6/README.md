# 📘 Day 6: Multi-Environment Isolation with Workspaces

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Understand Terraform Workspaces and how they manage separate state files.
- Learn why workspaces are useful for testing feature branches or lightweight environment isolation.
- Use the built-in variable `terraform.workspace`.
- Look up dynamic variables depending on active workspace (`lookup(local.instance_type, terraform.workspace)`).
- Learn CLI workspace management commands.

---

## 📂 Architecture
Workspaces create separate state paths under:
`env:/<workspace_name>/terraform.tfstate`

---

## 🚀 Step-by-Step Hands-on

1. **Check Workspaces**:
   ```bash
   terraform workspace list
   # Notice '*' marks the 'default' workspace
   ```

2. **Create and Switch to 'dev'**:
   ```bash
   terraform workspace new dev
   ```

3. **Deploy into 'dev'**:
   ```bash
   terraform init
   terraform apply
   ```
   *(Notice a `t2.micro` instance is deployed with the Name tag `dev-instance`)*

4. **Create and Switch to 'prod'**:
   ```bash
   terraform workspace new prod
   terraform apply
   ```
   *(Notice a `t2.small` or `t3.micro` instance is deployed with Name tag `prod-instance` without touching dev!)*

5. **List and Switch Between Environments**:
   ```bash
   terraform workspace list
   terraform workspace select dev
   terraform workspace show
   ```

6. **Clean Up**:
   ```bash
   terraform destroy -auto-approve
   terraform workspace select default
   terraform workspace delete dev
   ```
