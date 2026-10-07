output "state_bucket_name" {
  description = "Name of the S3 bucket to configure in your backend block"
  value       = aws_s3_bucket.tf_state.id
}

output "lock_table_name" {
  description = "Name of the DynamoDB table to configure in your backend dynamodb_table block"
  value       = aws_dynamodb_table.tf_locks.name
}

output "aws_region" {
  description = "AWS region of the state resources"
  value       = var.aws_region
}
