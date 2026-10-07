resource "aws_instance" "example" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
  subnet_id     = var.subnet_id_value != "" ? var.subnet_id_value : null

  tags = {
    Name      = var.instance_name
    ManagedBy = "Terraform-Module"
  }
}
