output "ssm_bucket_name" {
  description = "Name of the S3 bucket for SSM"
  value       = aws_s3_bucket.ssm_bucket.bucket
}

output "ssm_bucket_arn" {
  description = "ARN of the S3 bucket for SSM"
  value       = aws_s3_bucket.ssm_bucket.arn
}
