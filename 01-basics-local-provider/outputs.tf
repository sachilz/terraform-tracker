output "server_name" {
  description = "Randomly generated server identifier"
  value       = random_pet.server_name.id
}

output "file_path" {
  description = "Path of the created local file"
  value       = local_file.welcome_file.filename
}
