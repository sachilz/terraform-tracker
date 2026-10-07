variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Key pair name"
  type        = string
  default     = "terraform-day-5-key"
}
