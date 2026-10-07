variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI to deploy"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}
