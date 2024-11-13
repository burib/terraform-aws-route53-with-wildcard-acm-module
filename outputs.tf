output "wildcard_certificate_arn" {
  description = "The ARN of the certificate"
  value       = element(concat(aws_acm_certificate_validation.wildcard_cert.*.certificate_arn, aws_acm_certificate.wildcard_cert.*.arn, [""]), 0)
}

output "region" {
  value       = local.region
  description = "AWS Region code where this stack has been deployed to."
}

output "account_id" {
  value       = local.account_id
  description = "AWS Account ID where this stack has been deployed to."
}
