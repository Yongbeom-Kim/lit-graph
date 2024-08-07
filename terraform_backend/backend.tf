

locals {
  # The table must have a primary key named LockID.
  # See below for more detail.
  # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table
  lock_key_id = "LockID"
}

variable "dynamodb_hash_key" {
  type = string
}

variable "s3_bucket_prefix" {
  type = string
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "backend" {
  bucket_prefix = var.s3_bucket_prefix
}

resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "backend_lock" {
  name                        = "${aws_s3_bucket.backend.id}-lock"
  hash_key                    = local.lock_key_id
  deletion_protection_enabled = false
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = local.lock_key_id
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }


}

data "aws_region" "region" {
    
}

output "s3_bucket_name" {
    value = aws_s3_bucket.backend.id
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.backend_lock.name
}

output "aws_region" {
    value = data.aws_region.region.name
}