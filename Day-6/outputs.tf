output "current_workspace" {
  description = "The active workspace name"
  value       = terraform.workspace
}

output "selected_instance_type" {
  description = "Instance size chosen for this workspace"
  value       = local.instance_type
}

output "instance_id" {
  description = "Deployed EC2 instance ID"
  value       = aws_instance.env_server.id
}
