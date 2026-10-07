# ❓ Day 1: Questions & Answers (Q&A)

This document collects the key questions, common mistakes, and foundational concepts covered during Day 1 hands-on practice.

---

### Q1: How do I name an EC2 instance in Terraform?
In AWS, an EC2 instance name is assigned using a tag with the key **`Name`**.

In [`main.tf`](./main.tf), define `tags` **inside** the `aws_instance` resource block:
```hcl
resource "aws_instance" "example" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"

  tags = {
    Name = "my-ec2-instance"
  }
}
```

---

### Q2: What was the error `Argument or block definition is required here`?
* **Cause:** The `tags = { ... }` block was placed **outside** the closing bracket `}` of the `resource "aws_instance" "example"` block.
* **Rule:** In Terraform, resource configurations (like `ami`, `instance_type`, and `tags`) must always reside **inside** their respective resource blocks.

---

### Q3: How do I output the instance name?
In [`outputs.tf`](./outputs.tf), create an output referencing the tag:
```hcl
output "instance_name" {
  description = "The name tag of the EC2 instance"
  value       = aws_instance.example.tags["Name"]
}
```

---

### Q4: How do I rerun Terraform after modifying files?
Whenever you update `.tf` files, run the following commands in order:

1. **Validate syntax:**
   ```powershell
   terraform validate
   ```
2. **Preview changes:**
   ```powershell
   terraform plan
   ```
3. **Apply changes:**
   ```powershell
   terraform apply
   ```
   *(Type `yes` when prompted)*

4. **View outputs anytime:**
   ```powershell
   terraform output
   ```

---

### Q5: What is `outputs.tf`?
* It defines **Output Values** — similar to the `return` value of a function in programming.
* When AWS creates an instance, it generates dynamic information (such as the Instance ID and Public IP).
* `outputs.tf` tells Terraform to print these values directly in your terminal so you don't have to log into the AWS Management Console to find them.

---

### Q6: Why doesn't `outputs.tf` show the values inside the file?
* `outputs.tf` is only a **code definition** file. Terraform **never writes live values back into your `.tf` code files**.
* The values are stored in `terraform.tfstate`.
* To see the actual values, run:
  ```powershell
  terraform output
  ```

---

### Q7: What is `terraform.tfstate`? (Simple Explanation)
* **`terraform.tfstate` is Terraform's memory file (or notebook).**
* Terraform does not have a brain of its own. Every time you run a command, it reads `terraform.tfstate` to remember what it has already created in AWS.

#### Why is it essential?
1. **Prevents Duplicates:** If you run `terraform apply` again, Terraform checks `terraform.tfstate` and sees the instance is already running, avoiding creating duplicate instances and extra AWS charges.
2. **Deletions (`terraform destroy`):** Terraform checks `terraform.tfstate` to find the exact AWS resource IDs to delete.
3. **Caches Outputs:** Allows `terraform output` to display values instantly without querying AWS every time.

---

### 💡 The Restaurant Analogy to Remember Everything

| File / Component | Analogy | Description |
| :--- | :--- | :--- |
| **[`main.tf`](./main.tf)** | **Order Slip / Menu** 📝 | What you *want* to build. |
| **`terraform apply`** | **The Waiter** 👨‍🍳 | Takes your order and tells AWS to build it. |
| **`terraform.tfstate`** | **The Receipt** 🧾 | What is *actually built* in AWS right now. |
| **[`outputs.tf`](./outputs.tf)** | **The Summary** 📢 | Tells Terraform what key details to print on your screen. |
| **`terraform output`** | **Reading the Summary** 💻 | Terminal command to view your live outputs. |
