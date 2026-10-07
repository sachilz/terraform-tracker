variable "ami_value" {
  description = "AMI ID to launch"
  type        = string
}

variable "instance_type_value" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id_value" {
  description = "Subnet ID (optional)"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "terraform-module-ec2"
}
