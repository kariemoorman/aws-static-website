
resource "aws_s3_bucket_policy" "week1-s3-policy" {
  bucket = aws_s3_bucket.week1-bucket.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::mookarie-cloudops-w1/*"
        }
      ]
    })
}