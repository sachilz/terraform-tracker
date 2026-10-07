terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. AWS Key Pair for SSH access
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("${path.module}/id_rsa.pub")
}

# 2. Security Group allowing SSH (22) and HTTP (80)
resource "aws_security_group" "web_sg" {
  name        = "day5-web-security-group"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. EC2 Instance with Provisioners
resource "aws_instance" "server" {
  ami                    = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS (us-east-1)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # SSH connection configuration for provisioners
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }

  # remote-exec provisioner: Run commands directly on the server
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "echo '<h1>Provisioned with Terraform remote-exec (Day 5)</h1>' | sudo tee /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }

  # local-exec provisioner: Runs locally on your laptop after creation
  provisioner "local-exec" {
    command = "echo Server IP is ${self.public_ip} >> instance_ips.txt"
  }

  tags = {
    Name = "Provisioner-Demo"
  }
}
