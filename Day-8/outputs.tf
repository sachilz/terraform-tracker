output "vpc_id" {
  description = "Created VPC ID"
  value       = aws_vpc.custom_vpc.id
}

output "web_server_public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "Direct URL to access the deployed web application"
  value       = "http://${aws_instance.web_server.public_ip}"
}
