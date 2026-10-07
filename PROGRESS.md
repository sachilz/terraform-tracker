# 📊 Terraform Zero to Hero - Learning Tracker

Track your progress through Abhishek Veeramalla's [Terraform Zero to Hero YouTube Playlist](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf). Mark items complete by replacing `[ ]` with `[x]`.

---

### [ ] Day 1: Getting Started with Terraform
- [ ] Understand Infrastructure as Code (IaC) & Declarative model
- [ ] Install Terraform CLI & configure AWS credentials
- [ ] Understand Terraform Core Architecture & Providers
- [ ] Master core commands: `terraform init`, `plan`, `apply`, `destroy`
- [ ] Provision first EC2 instance on AWS
- [ ] Inspect generated `terraform.tfstate` file

### [ ] Day 2: Advanced Terraform Configuration
- [ ] Create and configure input variables (`variables.tf`)
- [ ] Work with variable types (`string`, `number`, `list`, `map`)
- [ ] Use AWS Data Sources (`data.aws_ami`) for dynamic image lookup
- [ ] Implement conditional logic (`condition ? val1 : val2`)
- [ ] Format and extract outputs (`outputs.tf`)
- [ ] Use `terraform.tfvars` for clean parameter management

### [ ] Day 3: Building Reusable Infrastructure with Modules
- [ ] Understand Root Module vs Child Module architecture
- [ ] Build custom reusable module (`modules/ec2_instance`)
- [ ] Pass variables into modules and capture outputs
- [ ] Explore the public Terraform Registry for verified modules

### [ ] Day 4: State Management & Remote Backend
- [ ] Understand state file importance and hazards of committing state to Git
- [ ] Provision remote backend infrastructure (AWS S3 + DynamoDB)
- [ ] Configure `backend "s3"` block in Terraform
- [ ] Understand state locking with DynamoDB
- [ ] Master state CLI commands (`terraform state list`, `show`, `pull`)

### [ ] Day 5: Provisioners & Connection Blocks
- [ ] Understand provisioners and connection types
- [ ] Use `remote-exec` to configure Nginx over SSH
- [ ] Use `local-exec` to capture outputs locally
- [ ] Learn why `user_data` and Cloud-init are preferred over provisioners

### [ ] Day 6: Environment Isolation with Workspaces
- [ ] Understand Terraform CLI workspaces
- [ ] Create and toggle workspaces (`dev`, `stage`, `prod`)
- [ ] Manage dynamic environment configurations using `terraform.workspace`
- [ ] Understand workspace state separation in S3

### [ ] Day 7: Security & Secrets Management
- [ ] Understand security risks of sensitive data in IaC
- [ ] Integrate AWS Secrets Manager / HashiCorp Vault
- [ ] Protect sensitive variables with `sensitive = true`
- [ ] Run static security scans using `tfsec` / Checkov

### [ ] Day 8: Real-World Capstone Project
- [ ] Provision full custom VPC, Subnet, Route Table & Internet Gateway
- [ ] Configure Security Groups for HTTP and SSH
- [ ] Deploy an automated Nginx web server using `user_data`
- [ ] Validate end-to-end web connectivity
