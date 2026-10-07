terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Replace the placeholders below with the outputs from 01-bootstrap-backend
  backend "s3" {
    bucket         = "REPLACE_WITH_YOUR_STATE_BUCKET_NAME"
    key            = "projects/sample-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "REPLACE_WITH_YOUR_DYNAMODB_LOCK_TABLE_NAME"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# Example resource to demonstrate remote state tracking
resource "aws_ssm_parameter" "sample_config" {
  name  = "/app/sample/backend_status"
  type  = "String"
  value = "Remote state with S3 and DynamoDB locking enabled successfully!"
}

output "ssm_parameter_name" {
  value = aws_ssm_parameter.sample_config.name
}
