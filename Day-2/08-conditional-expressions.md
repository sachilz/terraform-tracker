# 08 - Terraform Conditional Expressions & Locals

## 1. What is a Conditional Expression?

A **Conditional Expression** in Terraform allows you to choose between two values based on whether a condition evaluates to `true` or `false`.

It uses the standard **ternary syntax**:

```hcl
condition ? true_val : false_val
```

```text
                     Condition
                    (Is it True?)
                     /        \
                   YES         NO
                    ↓           ↓
                true_val    false_val
```

> **If the condition is `true`, the result is `true_val`.**
> **If the condition is `false`, the result is `false_val`.**

---

## 2. Combining Conditionals with `locals`

While you can put conditional expressions directly inside a resource, doing so repeatedly leads to duplicated, messy code. 

**`locals`** let you assign a name to an expression or calculation so you can define it once and reuse it everywhere.

### Declaring a Conditional in `locals`:
```hcl
locals {
  subnet_cidr = var.environment == "production" ? var.production_subnet_cidr : var.development_subnet_cidr
}
```

### Referencing the Local Value:
```hcl
resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.subnet_cidr # <--- Singular: local.<name>
}
```

> 💡 **Notice the syntax rule:**
> - The block is plural: **`locals { ... }`**
> - The reference is singular: **`local.<name>`**

---

## 3. How It Works in Practice

Suppose the following variables are supplied:

```hcl
environment             = "production"
production_subnet_cidr  = "10.0.1.0/24"
development_subnet_cidr = "10.0.2.0/24"
```

1. Terraform checks: `var.environment == "production"` → **TRUE**.
2. Terraform selects the first value: `var.production_subnet_cidr`.
3. `local.subnet_cidr` becomes `"10.0.1.0/24"`.
4. If `environment` were `"development"`, it would evaluate to **FALSE** and pick `"10.0.2.0/24"`.

---

## 4. Practical Real-World Examples

### Example A: Environment-Based Instance Sizing
```hcl
variable "environment" {
  type    = string
  default = "dev"
}

locals {
  # Choose a beefy instance for production, small instance for dev
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
}

resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = local.instance_type
}
```

### Example B: Conditional Resource Creation (`count`)
You can use conditionals to decide whether a resource should be created at all:

```hcl
variable "enable_elastic_ip" {
  type    = bool
  default = false
}

# If true, count = 1 (created). If false, count = 0 (skipped).
resource "aws_eip" "app_eip" {
  count    = var.enable_elastic_ip ? 1 : 0
  instance = aws_instance.web.id
}
```

---

## 5. `variable` vs. `locals`

This is a very common interview question:

| Feature | Input Variables (`variable`) | Local Values (`locals`) |
|---|---|---|
| **Purpose** | Accepts input from outside the project | Names internal calculations / expressions |
| **Source** | CLI (`-var`), `.tfvars`, or `default` | Computed entirely inside configuration |
| **User Modifiable?** | Yes, users can customize them | No, internal to the codebase |
| **Reference** | `var.<name>` | `local.<name>` |
| **Analogy** | Function Arguments | Local Variables inside a function |

```text
Variable = What the user inputs (e.g. environment = "prod")
Local    = What Terraform computes (e.g. instance_type = "t3.large")
```

---

## 6. Common Comparison Operators

| Operator | Meaning | Example |
|---|---|---|
| `==` | Equal to | `var.env == "prod"` |
| `!=` | Not equal to | `var.tier != "free"` |
| `>`, `<` | Greater / Less than | `var.count > 1` |
| `>=`, `<=` | Greater or equal / Less or equal | `var.instances >= 3` |
| `&&` | Logical AND | `var.env == "prod" && var.ha_enabled` |
| `\|\|` | Logical OR | `var.env == "dev" \|\| var.env == "test"` |
| `!` | Logical NOT | `!var.is_public` |

---

## 7. Are `locals` Mandatory?

**No.** You can place conditional expressions directly inside resource blocks. 

However, using `locals` is an **industry best practice** because:
1. It avoids duplicating long expressions across multiple resources.
2. It gives meaningful names to complex logic (self-documenting code).
3. If logic changes, you update it in **one place** instead of five.

---

## ⭐ Quick Revision Cheat Sheet

```text
┌──────────────────────────────┬────────────────────────────────────────────────────────┐
│ Syntax                       │ Description                                            │
├──────────────────────────────┼────────────────────────────────────────────────────────┤
│ condition ? true : false     │ Ternary conditional expression                         │
│ locals { name = ... }        │ Defines local computed values                          │
│ local.name                   │ References a local value in resources                  │
│ var.<name>                   │ Input from outside                                     │
│ local.<name>                 │ Value calculated inside                                │
│ count = cond ? 1 : 0         │ Pattern to conditionally enable/disable resources      │
└──────────────────────────────┴────────────────────────────────────────────────────────┘
```

### One-Line Takeaway:
> **Use conditional expressions (`? :`) to make decisions, and store complex or repeated results in `locals` for clean, readable code.**
