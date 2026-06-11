resource "aws_s3_bucket" "staging_backend_s3_bucket" {
    bucket = "staging-terraform-state-bucket-227957186238"
    
}

resource "aws_s3_bucket_versioning" "staging_backend_s3_bucket_versioning" {
  bucket = aws_s3_bucket.staging_backend_s3_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "staging_backend_s3_bucket_encryption" {
  bucket = aws_s3_bucket.staging_backend_s3_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "prod_backend_s3_bucket" {
    bucket = "prod-terraform-state-bucket-227957186238"
    
}

resource "aws_s3_bucket_versioning" "prod_backend_s3_bucket_versioning" {
  bucket = aws_s3_bucket.prod_backend_s3_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "prod_backend_s3_bucket_encryption" {
  bucket = aws_s3_bucket.prod_backend_s3_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "prod_backend_lock" {
    name = "prod-terraform-lock"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"
    attribute {
      name = "LockID"
      type = "S"
    }
}

resource "aws_dynamodb_table" "staging_backend_lock" {
    name = "staging-terraform-lock"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"
    attribute {
      name = "LockID"
      type = "S"
    }
}