output "s3_bucket_name" {
  description = "Bucket name to put in backend config"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "DynamoDB table name to put in backend config"
  value       = aws_dynamodb_table.terraform_locks.name
}
