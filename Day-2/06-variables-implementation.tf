# ==============================================================================
# 06 - Variables Implementation Demo
# ==============================================================================
# This configuration demonstrates:
# 1. Declaring input variables with and without defaults
# 2. Consuming variables inside an AWS resource (var.name)
# 3. Exposing resulting resource attributes through output values
#
# Commands to run:
#   terraform init
#   terraform plan -var="ami_id=ami-0c7217cdde317cfec"
#   terraform apply -var="ami_id=ami-0c7217cdde317cfec"
#   terraform output public_ip
#   terraform destroy
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Input Variables
# ------------------------------------------------------------------------------

# Input variable with a default fallback value
variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

# Input variable without default (must be supplied via CLI -var or .tfvars)
variable "ami_id" {
  description = "EC2 AMI ID (valid in us-east-1)"
  type        = string
  default     = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS (us-east-1)
}

# ------------------------------------------------------------------------------
# 2. Provider Configuration
# ------------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

# ------------------------------------------------------------------------------
# 3. Resource Definition (Using Variables)
# ------------------------------------------------------------------------------

resource "aws_instance" "example_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "Variables-Demo-Server"
  }
}

# ------------------------------------------------------------------------------
# 4. Output Values
# ------------------------------------------------------------------------------

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example_instance.public_ip
}
