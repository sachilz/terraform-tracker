output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}

output "instance_name" {
  description = "The name tag of the EC2 instance"
  value       = aws_instance.example.tags["Name"]
}
