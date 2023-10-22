###################################################
# Associated Route53 Private Hosted Zones
###################################################

resource "aws_route53_zone_association" "this" {
  for_each = toset(var.private_hosted_zones)

  vpc_id  = aws_vpc.this.id
  zone_id = each.value
}


###################################################
# Route53 DNSSEC Validation
###################################################

resource "aws_route53_resolver_dnssec_config" "this" {
  count = var.dns_dnssec_validation_enabled ? 1 : 0

  resource_id = aws_vpc.this.id
}
