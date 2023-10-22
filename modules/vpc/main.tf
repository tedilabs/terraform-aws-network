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

locals {
  ipv4_secondary_cidrs = slice(var.ipv4_cidrs, 1, length(var.ipv4_cidrs))
  ipv6_enabled         = length(var.ipv6_cidrs) > 0
  tenancy = {
    "DEFAULT"   = "default"
    "DEDICATED" = "dedicated"
  }
}


###################################################
# VPC
###################################################

resource "aws_vpc" "this" {
  ## IPv4 CIDR Blocks
  cidr_block = (var.ipv4_cidrs[0].type == "MANUAL"
    ? var.ipv4_cidrs[0].cidr
    : null
  )
  ipv4_ipam_pool_id = (var.ipv4_cidrs[0].type == "IPAM_POOL"
    ? var.ipv4_cidrs[0].ipam_pool.id
    : null
  )
  ipv4_netmask_length = (var.ipv4_cidrs[0].type == "IPAM_POOL"
    ? var.ipv4_cidrs[0].ipam_pool.netmask_length
    : null
  )


  ## IPv6 CIDR Blocks
  # TODO: Want to manage IPv6 CIDRs with `aws_vpc_ipv6_cidr_block_association` resource. But, there are unsupported featrues yet.
  assign_generated_ipv6_cidr_block = (local.ipv6_enabled
    ? (var.ipv6_cidrs[0].type == "AMAZON"
      ? true
      : null
    )
    : null
  )
  ipv6_cidr_block_network_border_group = (local.ipv6_enabled
    ? (var.ipv6_cidrs[0].type == "AMAZON"
      ? var.ipv6_cidrs[0].amazon.network_border_group
      : null
    )
    : null
  )
  ipv6_ipam_pool_id = (local.ipv6_enabled
    ? (var.ipv6_cidrs[0].type == "IPAM_POOL"
      ? var.ipv6_cidrs[0].ipam_pool.id
      : null
    )
    : null
  )
  ipv6_cidr_block = (local.ipv6_enabled
    ? (var.ipv6_cidrs[0].type == "IPAM_POOL"
      ? var.ipv6_cidrs[0].ipam_pool.cidr
      : null
    )
    : null
  )
  ipv6_netmask_length = (local.ipv6_enabled
    ? (var.ipv6_cidrs[0].type == "IPAM_POOL"
      ? var.ipv6_cidrs[0].ipam_pool.netmask_length
      : null
    )
    : null
  )


  ## Attributes
  instance_tenancy = local.tenancy[var.tenancy]

  enable_network_address_usage_metrics = var.network_address_usage_metrics_enabled

  enable_dns_hostnames = var.dns_hostnames_enabled
  enable_dns_support   = var.dns_resolution_enabled

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Additional CIDR Blocks for the VPC
###################################################

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = length(var.ipv4_cidrs) > 0 ? length(var.ipv4_cidrs) - 1 : 0

  vpc_id = aws_vpc.this.id
  cidr_block = (var.ipv4_cidrs[count.index + 1].type == "MANUAL"
    ? var.ipv4_cidrs[count.index + 1].cidr
    : null
  )
  ipv4_ipam_pool_id = (var.ipv4_cidrs[count.index + 1].type == "IPAM_POOL"
    ? var.ipv4_cidrs[count.index + 1].ipam_pool.id
    : null
  )
  ipv4_netmask_length = (var.ipv4_cidrs[count.index + 1].type == "IPAM_POOL"
    ? var.ipv4_cidrs[count.index + 1].ipam_pool.netmask_length
    : null
  )
}

resource "aws_vpc_ipv6_cidr_block_association" "this" {
  count = length(var.ipv6_cidrs) > 0 ? length(var.ipv6_cidrs) - 1 : 0

  vpc_id = aws_vpc.this.id
  ipv6_cidr_block = (var.ipv6_cidrs[count.index + 1].type == "IPAM_POOL"
    ? var.ipv6_cidrs[count.index + 1].ipam_pool.cidr
    : null
  )
  ipv6_ipam_pool_id = (var.ipv6_cidrs[count.index + 1].type == "IPAM_POOL"
    ? var.ipv6_cidrs[count.index + 1].ipam_pool.id
    : null
  )
  ipv6_netmask_length = (var.ipv6_cidrs[count.index + 1].type == "IPAM_POOL"
    ? var.ipv6_cidrs[count.index + 1].ipam_pool.netmask_length
    : null
  )
}
