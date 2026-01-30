resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "ssm_bucket" {
  bucket = "${var.project_name}-${var.environment}-ssm-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-${var.environment}-ssm-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "ssm_bucket" {
  bucket = aws_s3_bucket.ssm_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "ssm_bucket" {
  bucket = aws_s3_bucket.ssm_bucket.id

  rule {
    id     = "cleanup-old-objects"
    status = "Enabled"

    filter {
      prefix = ""
    }

    expiration {
      days = 7
    }
  }
}
