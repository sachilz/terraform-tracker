terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Terraform-Tracker"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Unique random suffix for S3 global uniqueness
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Primary S3 Bucket
resource "aws_s3_bucket" "tracker_bucket" {
  bucket = "${var.bucket_prefix}-${var.environment}-${random_id.bucket_suffix.hex}"

  # Protect against accidental deletion in production
  force_destroy = true # set to false in real production
}

# Enable Bucket Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tracker_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enforce Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tracker_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access for security best practices
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.tracker_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
