resource "aws_acm_certificate" "cert" {
  provider                  = aws.use_default_region
  domain_name               = "*.${var.simple_domain_name}"
  validation_method         = "DNS"
  subject_alternative_names = [var.simple_domain_name]

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "zone" {
  provider     = aws.use_default_region
  name         = var.simple_domain_name
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  provider = aws.use_default_region
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "cert" {
  provider                = aws.use_default_region
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.id
  name    = "www.${var.simple_domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn_static_site.domain_name
    zone_id                = aws_cloudfront_distribution.cdn_static_site.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.zone.id
  name    = var.simple_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn_static_site.domain_name
    zone_id                = aws_cloudfront_distribution.cdn_static_site.hosted_zone_id
    evaluate_target_health = false
  }
}