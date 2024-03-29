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

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  available_availablity_zones    = data.aws_availability_zones.available.names
  available_availablity_zone_ids = data.aws_availability_zones.available.zone_ids

  az = {
    for idx, id in local.available_availablity_zone_ids :
    id => local.available_availablity_zones[idx]
  }

  hostname_types = {
    "RESOURCE_NAME" = "resource-name"
    "IP_NAME"       = "ip-name"
  }
}

locals {
  availability_zones = distinct(
    values(aws_subnet.this)[*].availability_zone
  )
  availability_zone_ids = distinct(
    values(aws_subnet.this)[*].availability_zone_id
  )
  subnets = [
    for name, subnet in aws_subnet.this : {
      id   = subnet.id
      arn  = subnet.arn
      name = name

      availability_zone    = subnet.availability_zone
      availability_zone_id = subnet.availability_zone_id

      ipv4_cidr = subnet.cidr_block
      ipv6_cidr = subnet.ipv6_cidr_block
    }
  ]
}


###################################################
# Subnets of the Subnet Group
###################################################

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id               = var.vpc_id
  availability_zone    = each.value.availability_zone
  availability_zone_id = each.value.availability_zone_id

  enable_lni_at_device_index = var.local_network_interface_device_index


  ## IP CIDR Blocks
  ipv6_native = each.value.type == "IPV6"

  cidr_block      = each.value.ipv4_cidr
  ipv6_cidr_block = each.value.ipv6_cidr


  ## IP Assignments
  map_public_ip_on_launch = (each.value.type == "IPV6"
    ? false
    : var.public_ipv4_address_assignment.enabled
  )
  assign_ipv6_address_on_creation = (each.value.type == "IPV6"
    ? true
    : var.ipv6_address_assignment.enabled
  )
  map_customer_owned_ip_on_launch = (each.value.type == "IPV6"
    ? null
    : (var.customer_owned_ipv4_address_assignment.enabled
      ? true
      : null
    )
  )
  outpost_arn = (var.customer_owned_ipv4_address_assignment.enabled
    ? var.customer_owned_ipv4_address_assignment.outpost
    : null
  )
  customer_owned_ipv4_pool = (var.customer_owned_ipv4_address_assignment.enabled
    ? var.customer_owned_ipv4_address_assignment.pool
    : null
  )


  ## DNS Configurations
  private_dns_hostname_type_on_launch = (each.value.type == "IPV6"
    ? "resource-name"
    : local.hostname_types[var.dns_config.hostname_type]
  )
  enable_resource_name_dns_a_record_on_launch = (each.value.type == "IPV6"
    ? false
    : var.dns_config.dns_resource_name_ipv4_enabled
  )
  enable_resource_name_dns_aaaa_record_on_launch = (each.value.type == "IPV6"
    ? true
    : var.dns_config.dns_resource_name_ipv6_enabled
  )
  enable_dns64 = var.dns_config.dns64_enabled


  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
  }

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}
