# 05 - Terraform Variables & Outputs

## 1. What are Terraform Variables?

If you hardcode values (like instance sizes, AMI IDs, or names) directly in your resource code, you must manually edit the configuration every time you want to make a change.

**Variables make your Terraform code reusable, flexible, and dynamic.**

There are two fundamental directions:

```text
               ┌─────────────────────────────────┐
               │    Terraform Configuration      │
               └─────────────────────────────────┘
                   ▲                         │
                   │ (Pass values in)        │ (Expose values out)
                   │                         ▼
            Input Variables            Output Values
             (var.name)                 (output)
```

- **Input Variables** (`variable`): Values **you give** to Terraform to customize resources.
- **Output Values** (`output`): Values **Terraform gives back** to you after provisioning (e.g., Public IP, VPC ID).

> **Input = Give information to Terraform.**
> **Output = Get information from Terraform.**

---

## 2. Input Variables

### Declaring an Input Variable
Input variables are declared using the `variable` block:

```hcl
variable "instance_type" {
  description = "The EC2 instance type to launch"
  type        = string
  default     = "t2.micro"
}
```

### Breakdown of Arguments:

| Argument | Role | Is it Required? | Example |
|---|---|---|---|
| `variable "name"` | The identifier of the variable | **Yes** | `"instance_type"` |
| `description` | Documentation explaining what the variable is for | Recommended | `"The EC2 instance type"` |
| `type` | Type constraint restricting allowed data types | Recommended | `string`, `number`, `bool` |
| `default` | Fallback value if no value is explicitly supplied | Optional | `"t2.micro"` |

*(Note: If you do **not** supply a default value and don't provide one via CLI/tfvars, Terraform will interactively prompt you for it in the terminal during plan/apply!)*

---

## 3. How to Reference an Input Variable

Inside your resource blocks, you reference variables using:

```text
var.<variable_name>
```

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = var.instance_type # <--- Using the variable
  
  tags = {
    Name = "My-Web-Server"
  }
}
```

Instead of hardcoding `t2.micro`, Terraform dynamically reads the value from `var.instance_type`.

---

## 4. Common Variable Data Types

| Data Type | Example | Description |
|---|---|---|
| `string` | `"t2.micro"`, `"us-east-1"` | Text characters |
| `number` | `3`, `8080`, `2.5` | Numeric integers or floats |
| `bool` | `true`, `false` | Boolean flags |
| `list(string)` | `["subnet-1", "subnet-2"]` | Ordered list of items |
| `map(string)` | `{ env = "dev", owner = "devops" }` | Key-value pairs |
| `object(...)` | `{ name = string, port = number }` | Complex structured data |

---

## 5. How to Supply / Override Variable Values

Terraform provides multiple ways to set input variables:

### Method 1: Using the Default Value
If you run `terraform plan`, Terraform automatically uses the `default` defined in the block.

### Method 2: Command-Line Flag (`-var`)
You can override values directly from the terminal:
```bash
terraform plan -var="instance_type=t3.micro"
```

### Method 3: Using `terraform.tfvars` (Standard Method)
Create a file named `terraform.tfvars`. Terraform loads this file automatically:
```hcl
instance_type = "t3.medium"
```

---

## 6. Output Values

After Terraform creates infrastructure, you often need to know generated attributes (such as the assigned Public IP, DNS name, or Instance ID).

Output values expose these attributes to the terminal and other configurations.

### Declaring an Output:

```hcl
output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}
```

### How the `value` Expression Works:
```text
value = aws_instance.web.id
          │            │   └─ The exported attribute from AWS
          │            └───── The local resource name in your code
          └────────────────── The resource type
```

### Retrieving Outputs from the CLI:
After running `terraform apply`, Terraform prints outputs in the terminal. You can also query them at any time:
```bash
terraform output
terraform output instance_public_ip
terraform output -json
```

---

## 7. Referencing Outputs from Child Modules

When using modules, child modules expose outputs, and the root module can access them:

```text
Child Module (modules/ec2)           Root Module (main.tf)
┌────────────────────────┐           ┌──────────────────────────────────────────────┐
│ output "server_ip" {   │  ───────> │ output "public_ip" {                         │
│   value = aws_instance...          │   value = module.my_ec2_module.server_ip    │
│ }                      │           │ }                                            │
└────────────────────────┘           └──────────────────────────────────────────────┘
```

Syntax:
```hcl
module.<MODULE_NAME>.<OUTPUT_NAME>
```

Example:
```hcl
output "root_server_ip" {
  value = module.web_server.server_ip
}
```

---

## 8. Input Variables vs. Output Values

| Feature | Input Variable (`variable`) | Output Value (`output`) |
|---|---|---|
| **Purpose** | Pass configuration parameters into code | Expose resource attributes out of code |
| **Direction** | **INTO** Terraform | **OUT OF** Terraform |
| **Referenced As** | `var.<name>` | `module.<mod>.<output>` or CLI `terraform output` |
| **Analogy** | Function Parameters / Arguments | Function Return Value |

---

## 9. Complete Working Example

```hcl
# ==========================================
# 1. Input Variables
# ==========================================
variable "instance_name" {
  description = "Name tag for the EC2 server"
  type        = string
  default     = "dev-server"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

# ==========================================
# 2. Resource Configuration
# ==========================================
resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec" # Valid Ubuntu AMI in us-east-1
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

# ==========================================
# 3. Output Values
# ==========================================
output "instance_id" {
  description = "ID of the provisioned EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP address of the provisioned EC2 instance"
  value       = aws_instance.web.public_ip
}
```

---

## ⭐ Quick Revision Cheat Sheet

```text
┌─────────────────────────────────┬────────────────────────────────────────────────────────┐
│ Syntax                          │ Meaning                                                │
├─────────────────────────────────┼────────────────────────────────────────────────────────┤
│ variable "name" { ... }         │ Declare an input variable                              │
│ var.name                        │ Reference an input variable inside resources           │
│ output "name" { value = ... }   │ Expose an output attribute from state                  │
│ module.mod_name.output_name     │ Access a child module's output in the root module      │
│ terraform.tfvars                │ Standard file automatically loaded to assign variables │
│ -var="key=value"                │ Override variables via CLI                             │
└─────────────────────────────────┴────────────────────────────────────────────────────────┘
```
