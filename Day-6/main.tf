terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Lookup map for environment-based sizing
locals {
  instance_type_map = {
    default = "t2.micro"
    dev     = "t2.micro"
    stage   = "t2.micro"
    prod    = "t3.micro"
  }

  instance_type = lookup(local.instance_type_map, terraform.workspace, "t2.micro")
}

resource "aws_instance" "env_server" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = local.instance_type

  tags = {
    Name        = "${terraform.workspace}-instance"
    Environment = terraform.workspace
    ManagedBy   = "Terraform-Workspaces"
  }
}
