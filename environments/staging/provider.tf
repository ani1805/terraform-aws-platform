terraform {
  required_version = ">=1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "staging-terraform-state-bucket-227957186238"
    region         = "ap-south-1"
    key            = "staging/terraform.tfstate"
    dynamodb_table = "staging-terraform-lock"
  }
}
provider "aws" {
  region = var.aws_region
}