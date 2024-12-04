# terraform-route53-with-wildcard-acm-module

### creates a Route53 Public Hosted Zone with Wildcard ACM Certificate validated through dns records. 
###### For DNS validation make sure the propagation works by creating the required NS records after the HZ is created. 
###### Otherwise the certificate will never get verified and terraform keeps hanging.  


# Usage example:
```terraform
module "my_awesome_domain" {
  source = "github.com/burib/terraform-aws-route53-with-wildcard-acm-module?ref=v0"

  domain = local.is_prod ? "example.com" : "${var.environment}.example.com"
}
```
