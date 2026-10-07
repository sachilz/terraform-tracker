output "public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.server.public_ip
}

output "ssh_command" {
  description = "Command to SSH into instance"
  value       = "ssh -i id_rsa ubuntu@${aws_instance.server.public_ip}"
}
