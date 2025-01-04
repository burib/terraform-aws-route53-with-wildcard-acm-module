resource "aws_route53_zone" "this" {
  name = var.domain
}

# Certificate
resource "aws_acm_certificate" "wildcard_cert" {
  domain_name       = aws_route53_zone.this.name
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${aws_route53_zone.this.name}"
  ]
}

resource "aws_acm_certificate_validation" "wildcard_cert" {
  certificate_arn = aws_acm_certificate.wildcard_cert.arn
  validation_record_fqdns = [
    aws_route53_record.wildcard_cert_validation.fqdn
  ]
}

resource "aws_route53_record" "wildcard_cert_validation" {
  name    = tolist(aws_acm_certificate.wildcard_cert.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.wildcard_cert.domain_validation_options)[0].resource_record_type
  zone_id = aws_route53_zone.this.zone_id
  records = [
    tolist(aws_acm_certificate.wildcard_cert.domain_validation_options)[0].resource_record_value
  ]
  ttl = "60"
}

resource "aws_ssm_parameter" "hosted_zone_id" {
  name        = "/zones/${replace(aws_route53_zone.this.name, ".", "-DOT-")}/id"
  value       = aws_route53_zone.this.zone_id
  description = "Route53 Hosted Zone ID for ${aws_route53_zone.this.name}"
  type        = "String"
}

resource "aws_ssm_parameter" "wildcard_cert_arn" {
  name        = "/certificates/${replace(aws_route53_zone.this.name, ".", "-DOT-")}/wildcard/arn"
  value       = aws_acm_certificate.wildcard_cert.arn
  description = "Wildcard Certificate ARN of *.${aws_route53_zone.this.name}"
  type        = "String"
}
