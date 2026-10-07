variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags map to assign to all resources"
  type        = map(string)
  default = {
    Owner     = "DevOps-Student"
    ManagedBy = "Terraform"
  }
}
