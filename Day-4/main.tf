terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote backend configuration
  # Replace placeholders with values from backend_infra outputs
  backend "s3" {
    bucket         = "REPLACE_WITH_S3_BUCKET_NAME"
    key            = "day-4/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "REPLACE_WITH_DYNAMODB_TABLE_NAME"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# Example resource managed under remote state
resource "aws_instance" "remote_state_demo" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"

  tags = {
    Name      = "RemoteState-Demo"
    ManagedBy = "Terraform-Remote-S3"
  }
}
