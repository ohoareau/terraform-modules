provider "aws" {
}
provider "aws" {
  alias = "acm"
}

resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
  acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = {
    Website = var.name
  }
}

resource "aws_s3_bucket" "website_redirect_apex" {
  count = var.apex_redirect ? 1 : 0
  bucket = "www.${var.bucket_name}"
  acl    = "public-read"
  website {
    redirect_all_requests_to = "https://${var.dns}"
  }
  tags = {
    Website = var.name
  }
}

resource "aws_cloudfront_distribution" "website" {
  origin {
    domain_name         = aws_s3_bucket.website.website_endpoint
    origin_id           = "website-${var.name}-s3"
    custom_origin_config {
      // These are all the defaults.
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Website ${var.name} Distribution"
  default_root_object = "index.html"

  aliases = [var.dns]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "website-${var.name}-s3"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = var.geolocations
    }
  }

  tags = {
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  custom_error_response {
    error_code    = 403
    response_code = 200
    response_page_path = var.error_403_path
  }

  custom_error_response {
    error_code    = 404
    response_code = 200
    response_page_path = var.error_404_path
  }
}
resource "aws_cloudfront_distribution" "website_redirect_apex" {
  count = var.apex_redirect ? 1 : 0
  origin {
    domain_name         = aws_s3_bucket.website_redirect_apex.website_endpoint
    origin_id           = "website-${var.name}-s3"
    custom_origin_config {
      // These are all the defaults.
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Website ${var.name} Redirect to Apex Distribution"

  aliases = ["www.${var.dns}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "website-${var.name}-s3"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

resource "aws_route53_record" "website" {
  zone_id = var.zone
  name    = var.dns
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "website_redirect_apex" {
  count = var.apex_redirect ? 1 : 0
  zone_id = var.zone
  name    = "www.${var.dns}"
  type    = "CNAME"

  alias {
    name                   = aws_cloudfront_distribution.website_redirect_apex.domain_name
    zone_id                = aws_cloudfront_distribution.website_redirect_apex.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_acm_certificate" "cert" {
  domain_name       = var.dns
  validation_method = "DNS"
  provider          = "aws.acm"

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = var.zone
  records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
}
resource "aws_acm_certificate_validation" "cert" {
  provider                = "aws.acm"
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

data "aws_iam_policy_document" "s3_website_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.website.arn]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_website_policy.json
}

data "aws_iam_policy_document" "s3_website_redirect_apex_policy" {
  count = var.apex_redirect ? 1 : 0
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website_redirect_apex.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.website_redirect_apex.arn]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
resource "aws_s3_bucket_policy" "website_redirect_apex" {
  count = var.apex_redirect ? 1 : 0
  bucket = aws_s3_bucket.website_redirect_apex.id
  policy = data.aws_iam_policy_document.s3_website_redirect_apex_policy.json
}
