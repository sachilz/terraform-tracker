output "bucket_name" {
  description = "The globally unique name of the created S3 bucket"
  value       = aws_s3_bucket.tracker_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket"
  value       = aws_s3_bucket.tracker_bucket.arn
}

output "bucket_region" {
  description = "AWS Region the bucket was deployed to"
  value       = aws_s3_bucket.tracker_bucket.region
}
