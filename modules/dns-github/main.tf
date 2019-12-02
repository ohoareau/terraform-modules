resource "aws_route53_record" "github-challenge" {
  zone_id = var.zone
  name    = "_github-challenge-${var.challenge_organization}"
  type    = "TXT"
  records = [var.challenge_verification_id]
  ttl     = var.challenge_ttl
  count   = var.challenge_organization != "" ? 1 : 0
}