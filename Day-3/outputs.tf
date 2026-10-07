output "web_server_ip" {
  description = "Public IP exported from child module"
  value       = module.ec2_web_server.public_ip_address
}

output "web_server_id" {
  description = "Instance ID exported from child module"
  value       = module.ec2_web_server.instance_id
}
