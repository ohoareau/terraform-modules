provider "aws" {
}
provider "aws" {
  alias = "acm"
}

resource "aws_apigatewayv2_domain_name" "api" {
  depends_on  = [aws_acm_certificate_validation.cert]
  domain_name = var.dns
  domain_name_configuration {
    certificate_arn = aws_acm_certificate.cert.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "api" {
  api_id      = var.api
  domain_name = aws_apigatewayv2_domain_name.api.id
  stage       = var.stage
}

resource "aws_route53_record" "api" {
  zone_id = var.zone
  name    = aws_apigatewayv2_domain_name.api.domain_name
  type    = "A"

  alias {
    name                   = element(tolist(aws_apigatewayv2_domain_name.api.domain_name_configuration), 0).target_domain_name
    zone_id                = element(tolist(aws_apigatewayv2_domain_name.api.domain_name_configuration), 0).hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.dns
  validation_method = "DNS"
  provider          = aws.acm
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_name
  type    = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_type
  zone_id = var.zone
  records = [element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  provider                = aws.acm
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
