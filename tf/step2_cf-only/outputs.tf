
output "s3_bucket_id" {
  value = aws_s3_bucket_website_configuration.blog.website_endpoint
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.cdn_static_site.domain_name
}