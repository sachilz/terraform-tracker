output "ami_id_discovered" {
  description = "The Ubuntu AMI dynamically discovered via data source"
  value       = data.aws_ami.ubuntu.id
}

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
