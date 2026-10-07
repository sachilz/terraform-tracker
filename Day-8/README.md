# 📘 Day 8: Real-World Capstone Project (VPC & Web Infrastructure)

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Consolidate all concepts learned from Day 1 through Day 7:
  - Custom VPC with Public Subnet and Internet Gateway
  - Route Table & Route Table Association
  - Secure Security Group allowing HTTP (80) and SSH (22)
  - EC2 Instance with automated `user_data` bootstrap script running Nginx
  - Modular, parameterized inputs and clear outputs

---

## 📂 Architecture Diagram
```text
                  Internet
                     │
            [Internet Gateway]
                     │
          [VPC (10.0.0.0/16)]
                     │
       [Public Subnet (10.0.1.0/24)]
                     │
    [Security Group: Port 80, 22]
                     │
         [EC2 Instance: Nginx]
```

---

## 🚀 How to Run

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Validate & Plan**:
   ```bash
   terraform fmt
   terraform validate
   terraform plan
   ```

3. **Deploy the Infrastructure**:
   ```bash
   terraform apply
   ```

4. **Access the Web Server**:
   Copy the `website_url` from the outputs and open it in your browser!

5. **Tear Down**:
   ```bash
   terraform destroy -auto-approve
   ```
