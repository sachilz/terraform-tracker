terraform {
  required_version = ">= 1.5.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
  }
}

# Generate an environment configuration file using the input variables
resource "local_file" "config_file" {
  filename = "${path.module}/config_${var.environment}.json"
  content = jsonencode({
    project          = var.project_name
    environment      = var.environment
    port             = var.app_port
    active_features  = var.features_enabled
    resource_tags    = var.tags
    database         = var.database_config
  })
}
