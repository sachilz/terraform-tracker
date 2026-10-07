output "app_summary" {
  description = "Summary of application configuration"
  value = {
    project_name = var.project_name
    environment  = var.environment
    port         = var.app_port
    file_path    = local_file.config_file.filename
  }
}

output "features_count" {
  description = "Number of enabled features"
  value       = length(var.features_enabled)
}

# Demonstrating sensitive output handling
output "masked_db_secret" {
  description = "Demonstration of sensitive password (hidden in CLI logs)"
  value       = var.db_password
  sensitive   = true
}
