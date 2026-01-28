terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Professional Best Practice: S3 Backend
  # Enable this block after creating an S3 bucket and DynamoDB table
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "ansible-terraform/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = "us-east-1"
}
