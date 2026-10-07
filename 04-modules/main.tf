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

# Dev Environment Website instance
module "dev_website" {
  source = "./modules/s3_website"

  site_name   = "${var.project_name}-dev"
  environment = "dev"
}

# Prod Environment Website instance
module "prod_website" {
  source = "./modules/s3_website"

  site_name   = "${var.project_name}-prod"
  environment = "prod"
}
