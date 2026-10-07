variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "db_password" {
  description = "Sensitive database administrator password"
  type        = string
  sensitive   = true
  default     = "SuperSecretSecurePassw0rd!"
}
