# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a basic EC2 Instance (Ubuntu 22.04 LTS AMI in us-east-1)
resource "aws_instance" "example" {
  ami           = "ami-0b6d9d3d33ba97d99" # Update to valid Ubuntu AMI in your region if needed
  instance_type = "t3.micro"
  tags = {
    Name = "my-ec2-instance"
  }
}
