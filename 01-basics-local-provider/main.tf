terraform {
  required_version = ">= 1.5.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

# Generate a random string/pet name to use as a dynamic identifier
resource "random_pet" "server_name" {
  length    = 2
  separator = "-"
}

# Create a local file with interpolated content
resource "local_file" "welcome_file" {
  filename = "${path.module}/generated_welcome.txt"
  content  = <<-EOT
    ==================================================
    Welcome to Terraform!
    ==================================================
    Generated Server Name: ${random_pet.server_name.id}
    Timestamp Created    : ${timestamp()}
    Environment          : Local Sandbox (Zero Cost)
    ==================================================
  EOT
}
