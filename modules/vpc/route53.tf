###################################################
# Associated Route53 Private Hosted Zones
###################################################

resource "aws_route53_zone_association" "this" {
  for_each = var.route53_resolver.private_hosted_zones

  vpc_region = aws_vpc.this.region
  vpc_id     = aws_vpc.this.id

  zone_id = each.value
}


###################################################
# Associated Route53 Profiles
###################################################

resource "aws_route53profiles_association" "this" {
  count = var.route53_resolver.profile_association != null ? 1 : 0

  region = aws_vpc.this.region

  resource_id = aws_vpc.this.id

  name       = var.route53_resolver.profile_association.name
  profile_id = var.route53_resolver.profile_association.profile

  tags = merge(
    {
      "Name" = var.route53_resolver.profile_association.name
    },
    local.module_tags,
    var.tags,
    var.route53_resolver.profile_association.tags,
  )
}


###################################################
# DNSSEC Validation
###################################################

resource "aws_route53_resolver_dnssec_config" "this" {
  count = var.route53_resolver.dnssec_validation.enabled ? 1 : 0

  region = var.region

  resource_id = aws_vpc.this.id
}


###################################################
# Autodefined Rules for Reverse DNS Resolution
###################################################

resource "aws_route53_resolver_config" "this" {
  region = var.region

  resource_id              = aws_vpc.this.id
  autodefined_reverse_flag = var.route53_resolver.autodefined_reverse_dns_resolution_enabled ? "ENABLE" : "DISABLE"
}
