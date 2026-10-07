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

# Store secret in AWS Secrets Manager (or Vault)
resource "aws_secretsmanager_secret" "db_secret" {
  name                    = "app/database/credentials"
  recovery_window_in_days = 0 # Immediate deletion on destroy for lab
}

resource "aws_secretsmanager_secret_version" "db_secret_val" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = var.db_password
  })
}
