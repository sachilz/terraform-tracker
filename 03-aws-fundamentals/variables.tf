variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "tf-tracker"
}

variable "environment" {
  description = "Environment identifier (e.g. dev, prod)"
  type        = string
  default     = "dev"
}
