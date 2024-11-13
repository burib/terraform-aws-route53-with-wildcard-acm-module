output "wildcard_certificate_arn" {
  description = "The ARN of the certificate"
  value       = element(concat(aws_acm_certificate_validation.wildcard_cert.*.certificate_arn, aws_acm_certificate.wildcard_cert.*.arn, [""]), 0)
}

output "hosted_zone_ns_records" {
  description = "Name servers of the created hosted zone."
  value       = aws_route53_zone.this.name_servers
}

output "hosted_zone_arn" {
  description = "The ARN of the hosted zone"
  value       = aws_route53_zone.this.zone_arn
}

output "hosted_zone_id" {
  description = "The ID of the hosted zone"
  value       = aws_route53_zone.this.zone_id
}

output "hosted_zone_name" {
  description = "Name of the hosted zone. example.com"
  value       = aws_route53_zone.this.name
}

output "region" {
  value       = local.region
  description = "AWS Region code where this stack has been deployed to."
}

output "account_id" {
  value       = local.account_id
  description = "AWS Account ID where this stack has been deployed to."
}
