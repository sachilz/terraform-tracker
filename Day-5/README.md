# 📘 Day 5: Provisioners & Connection Blocks

> **Course Reference:** [Terraform Zero to Hero by Abhishek Veeramalla](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf)

---

## 🎯 Objectives
- Understand what Provisioners are and their purpose.
- Explore the 3 types of provisioners:
  1. `file`: Copy files from your machine into the created VM.
  2. `remote-exec`: Execute commands directly on the remote VM via SSH.
  3. `local-exec`: Run local terminal commands on your own machine after resource creation.
- Understand failure behaviors (`on_failure = continue` vs `fail`).
- Learn why provisioners should be a **last resort** and why Cloud-init / `user_data` / Ansible are preferred in production.

---

## 📂 Files Overview
- [`main.tf`](./main.tf): Sets up Key Pair, Security Group (allowing SSH port 22 and HTTP port 80), EC2 instance, and executes `remote-exec` to configure an Nginx web server.
- [`variables.tf`](./variables.tf): Key name and network configuration.
- [`outputs.tf`](./outputs.tf): Public IP and SSH login command.

---

## 🚀 How to Run

1. **Generate SSH Key Pair locally** (if you don't already have one):
   ```bash
   ssh-keygen -t rsa -b 2048 -f id_rsa -N ""
   ```

2. **Initialize and Apply**:
   ```bash
   terraform init
   terraform apply
   ```

3. **Observe the terminal output**:
   Terraform will connect via SSH, install Python/Nginx, and start the service!

4. **Test in Browser**:
   Open `http://<instance_public_ip>` in your browser.

5. **Clean Up**:
   ```bash
   terraform destroy -auto-approve
   ```
