output "secret_arn" {
  description = "ARN of the generated AWS Secret"
  value       = aws_secretsmanager_secret.db_secret.arn
}

output "secret_value_masked" {
  description = "Demonstration of sensitive output suppression in CLI logs"
  value       = var.db_password
  sensitive   = true
}
