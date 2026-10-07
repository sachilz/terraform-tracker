variable "site_name" {
  description = "Name identifier for the website"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
