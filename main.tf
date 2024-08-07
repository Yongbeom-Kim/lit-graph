terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.61.0"
    }
  }

  backend "s3" {
    // from terraform_backend/main.tf
    bucket = "terraform-tfstate-lit-graph20240807142559322900000001"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-tfstate-lit-graph20240807142559322900000001-lock"
  }
}

provider "null" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "backend" {
  bucket_prefix = "lit-graph-test-${terraform.workspace}"
}