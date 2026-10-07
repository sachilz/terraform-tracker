variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-tracker"
}

variable "environment" {
  description = "Target deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be either 'dev', 'staging', or 'prod'."
  }
}

variable "app_port" {
  description = "Application port number"
  type        = number
  default     = 3000

  validation {
    condition     = var.app_port > 1024 && var.app_port <= 65535
    error_message = "The app_port must be an unprivileged port between 1025 and 65535."
  }
}

variable "features_enabled" {
  description = "List of feature flags enabled for this deployment"
  type        = list(string)
  default     = ["logging", "monitoring"]
}

variable "tags" {
  description = "Common tags to apply across resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Owner     = "DevOps"
  }
}

variable "database_config" {
  description = "Configuration settings for database connection"
  type = object({
    db_name  = string
    max_conn = number
  })
  default = {
    db_name  = "app_db"
    max_conn = 50
  }
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
  default     = "SuperSecretPassword123!"
}
