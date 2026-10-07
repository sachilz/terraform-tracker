output "bucket_name" {
  description = "The name of the website S3 bucket"
  value       = aws_s3_bucket.website_bucket.id
}

output "website_endpoint" {
  description = "Public URL endpoint of the hosted website"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}
