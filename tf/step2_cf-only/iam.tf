data "aws_iam_policy_document" "week1-s3-policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.week1-bucket.arn}/*"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.cdn_static_site.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.week1-bucket.id
  policy = data.aws_iam_policy_document.week1-s3-policy.json
}
