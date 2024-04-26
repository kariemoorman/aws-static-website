# Create S3 bucket
resource "aws_s3_bucket" "week1-bucket" {
  bucket = "mookarie-cloudops-w1"

  tags = {
    name        = "week_1"
    environment = "Dev"
  }
}

# Create a block public access configuration
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.week1-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Add S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "week1_bucket_versioning" {
  bucket = aws_s3_bucket.week1-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encrypt S3 bucket using SSE-S3
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.week1-bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Configure website documents
resource "aws_s3_bucket_website_configuration" "blog" {
  bucket = aws_s3_bucket.week1-bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Upload HTML files to S3
resource "aws_s3_object" "upload_object" {
  for_each      = fileset("../../html/", "*")
  bucket        = aws_s3_bucket.week1-bucket.id
  key           = each.value
  source        = "../../html/${each.value}"
  etag          = filemd5("../../html/${each.value}")
  content_type  = "text/html"
  depends_on = [ aws_s3_bucket.week1-bucket ]
}

# Create Log bucket
resource "aws_s3_bucket" "log_bucket" {
  bucket = "tf-log-bucket"
}

# Create a block public access configuration
resource "aws_s3_bucket_public_access_block" "log_block" {
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Add ACL
resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

# Add versioning
resource "aws_s3_bucket_versioning" "log_bucket_versioning" {
  bucket = aws_s3_bucket.log_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Add logging
resource "aws_s3_bucket_logging" "s3log" {
  bucket = aws_s3_bucket.week1-bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

# Encrypt S3 bucket using SSE-S3
resource "aws_s3_bucket_server_side_encryption_configuration" "logs3-encrypt" {
  bucket = aws_s3_bucket.log_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
