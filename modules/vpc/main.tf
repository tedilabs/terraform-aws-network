locals {
  metadata = {
    package = "terraform-aws-network"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

resource "aws_vpc" "this" {
  cidr_block                       = var.cidr_block
  assign_generated_ipv6_cidr_block = var.ipv6_enabled

  instance_tenancy = var.instance_tenancy

  enable_dns_hostnames = var.dns_hostnames_enabled
  enable_dns_support   = var.dns_support_enabled

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  for_each = toset(var.secondary_cidr_blocks)

  vpc_id     = aws_vpc.this.id
  cidr_block = each.key
}


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


###################################################
# DHCP Options
###################################################

data "aws_region" "current" {}

locals {
  current_region                   = data.aws_region.current.name
  default_dhcp_options_domain_name = local.current_region != "us-east-1" ? "${local.current_region}.compute.internal" : "ec2.internal"
}

resource "aws_vpc_dhcp_options" "this" {
  count = var.dhcp_options_enabled ? 1 : 0

  domain_name          = var.dhcp_options_domain_name != "" ? var.dhcp_options_domain_name : local.default_dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.dhcp_options_enabled ? 1 : 0

  vpc_id          = aws_vpc.this.id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}


###################################################
# Internet Gateway
###################################################

resource "aws_internet_gateway" "this" {
  count = var.internet_gateway_enabled ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Egress Only Internet Gateway (IPv6)
###################################################

resource "aws_egress_only_internet_gateway" "this" {
  count = var.ipv6_enabled && var.egress_only_internet_gateway_enabled ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Virtual Private Gateway
###################################################

resource "aws_vpn_gateway" "this" {
  count = var.vpn_gateway_enabled ? 1 : 0

  vpc_id = aws_vpc.this.id
  # TODO: I don't know why this variable is needed
  # availability_zone = "ap-northeast-2a"
  amazon_side_asn = var.vpn_gateway_asn

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
