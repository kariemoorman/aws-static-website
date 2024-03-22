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
