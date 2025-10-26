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
  region = var.region

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

  block_public_access_exclusion_mode = {
    "BIDIRECTIONAL" = "allow-bidirectional"
    "EGRESS"        = "allow-egress"
    "OFF"           = "off"
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

      ipv4_cidr_reservations = var.subnets[name].ipv4_cidr_reservations
      ipv6_cidr_reservations = var.subnets[name].ipv6_cidr_reservations
    }
  ]
}


###################################################
# Subnets of the Subnet Group
###################################################

resource "aws_subnet" "this" {
  for_each = var.subnets

  region = var.region

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


###################################################
# CIDR Reservations for Subnets of the Subnet Group
###################################################

locals {
  ipv4_cidr_reservations = flatten([
    for name, subnet in var.subnets :
    [
      for reservation in subnet.ipv4_cidr_reservations :
      merge(reservation, {
        id     = "${name}/${reservation.ipv4_cidr}"
        subnet = aws_subnet.this[name]
      })
    ]
  ])
  ipv6_cidr_reservations = flatten([
    for name, subnet in var.subnets :
    [
      for reservation in subnet.ipv6_cidr_reservations :
      merge(reservation, {
        id     = "${name}/${reservation.ipv6_cidr}"
        subnet = aws_subnet.this[name]
      })
    ]
  ])
}

resource "aws_ec2_subnet_cidr_reservation" "ipv4" {
  for_each = {
    for reservation in local.ipv4_cidr_reservations :
    reservation.id => reservation
  }

  region = each.value.subnet.region

  subnet_id = each.value.subnet.id

  cidr_block       = each.value.ipv4_cidr
  reservation_type = lower(each.value.type)
  description      = each.value.description
}

resource "aws_ec2_subnet_cidr_reservation" "ipv6" {
  for_each = {
    for reservation in local.ipv6_cidr_reservations :
    reservation.id => reservation
  }

  region = each.value.subnet.region

  subnet_id = each.value.subnet.id

  cidr_block       = each.value.ipv6_cidr
  reservation_type = lower(each.value.type)
  description      = each.value.description
}


###################################################
# Block Public Access Exclusion for the Subnet Group
###################################################

# INFO: Not supported attributes
# - `vpc_id`
resource "aws_vpc_block_public_access_exclusion" "this" {
  for_each = (var.block_public_access_exclusion_mode != "OFF"
    ? aws_subnet.this
    : {}
  )

  region = var.region

  subnet_id                       = each.value.id
  internet_gateway_exclusion_mode = local.block_public_access_exclusion_mode[var.block_public_access_exclusion_mode]

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}
