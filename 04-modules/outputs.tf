output "dev_website_url" {
  description = "URL for the development website"
  value       = "http://${module.dev_website.website_endpoint}"
}

output "prod_website_url" {
  description = "URL for the production website"
  value       = "http://${module.prod_website.website_endpoint}"
}
