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
  address_family = {
    "IPV4" = "ipv4"
    "IPV6" = "ipv6"
  }

  primary_peering    = var.bgp_peerings[0]
  secondary_peerings = slice(var.bgp_peerings, 1, length(var.bgp_peerings))

  routers    = jsondecode(file("${path.module}/routers.json"))
  router_ids = local.routers[*].id
}


###################################################
# Private VIF (Virtual Interface) of Direct Connect
###################################################

resource "aws_dx_private_virtual_interface" "this" {
  name = var.name

  connection_id = var.connection

  dx_gateway_id = (var.gateway.type == "DIRECT_CONNECT_GATEWAY"
    ? var.gateway.id
    : null
  )
  vpn_gateway_id = (var.gateway.type == "VIRTUAL_PRIVATE_GATEWAY"
    ? var.gateway.id
    : null
  )

  vlan             = var.vlan
  mtu              = var.jumbo_frame_enabled ? 9001 : 1500
  sitelink_enabled = var.sitelink_enabled

  ## BGP Peering
  address_family = local.address_family[local.primary_peering.address_family]
  bgp_asn        = local.primary_peering.bgp_asn
  bgp_auth_key   = local.primary_peering.bgp_auth_key

  amazon_address   = local.primary_peering.amazon_address
  customer_address = local.primary_peering.customer_address

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Additional BGP Peerings for Private VIF
###################################################

resource "aws_dx_bgp_peer" "this" {
  for_each = {
    for peering in local.secondary_peerings :
    "${peering.address_family}/${peering.bgp_asn}" => peering
  }

  virtual_interface_id = aws_dx_private_virtual_interface.this.id

  address_family = local.address_family[each.value.address_family]

  bgp_asn      = each.value.bgp_asn
  bgp_auth_key = each.value.bgp_auth_key

  amazon_address   = each.value.amazon_address
  customer_address = each.value.customer_address
}


###################################################
# Sample Router Configuration for Private VIF (Virtual Interface)
###################################################

data "aws_dx_router_configuration" "this" {
  count = var.router != null ? 1 : 0

  virtual_interface_id   = aws_dx_private_virtual_interface.this.id
  router_type_identifier = var.router

  lifecycle {
    precondition {
      condition     = contains(local.router_ids, var.router)
      error_message = "Not supported router ID: ${var.router}."
    }
  }
}
