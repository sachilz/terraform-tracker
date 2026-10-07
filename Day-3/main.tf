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

# Invoking custom child module
module "ec2_web_server" {
  source = "./modules/ec2_instance"

  ami_value           = var.ami_id
  instance_type_value = "t2.micro"
  instance_name       = "Module-Demo-Server"
}
