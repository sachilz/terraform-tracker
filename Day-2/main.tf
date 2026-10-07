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

# Data Source: Automatically find the latest Ubuntu 22.04 LTS AMI in the configured region
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical official owner ID
}

# Conditional Expression: Prod instances get a specific naming prefix
locals {
  name_prefix = var.environment == "prod" ? "PROD-SERVER" : "DEV-SERVER"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = merge(
    var.tags,
    {
      Name        = "${local.name_prefix}-app"
      Environment = var.environment
    }
  )
}
