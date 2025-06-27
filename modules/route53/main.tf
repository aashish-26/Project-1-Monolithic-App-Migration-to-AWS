resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "alias" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

output "zone_id" {
  value = aws_route53_zone.primary.zone_id
}
