terraform {
  required_version = ">= 1.5.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
  }
}

locals {
  # Dynamic environment sizing mapping
  env_config = {
    default = { replicas = 1, tier = "standard" }
    dev     = { replicas = 1, tier = "standard" }
    prod    = { replicas = 3, tier = "premium" }
  }

  current_config = lookup(local.env_config, terraform.workspace, local.env_config["default"])
}

resource "local_file" "environment_metadata" {
  filename = "${path.module}/env_${terraform.workspace}.json"
  content = jsonencode({
    workspace    = terraform.workspace
    tier         = local.current_config.tier
    replicas     = local.current_config.replicas
    generated_at = timestamp()
  })
}

output "active_workspace" {
  value = terraform.workspace
}

output "workspace_config" {
  value = local.current_config
}
