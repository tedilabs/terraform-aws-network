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

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_main_route_table_association" "this" {
  count = var.is_main ? 1 : 0

  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.this.id
}


###################################################
# Routes
###################################################

resource "aws_route" "ipv4" {
  for_each = {
    for route in var.ipv4_routes :
    route.cidr_block => route
  }

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = each.key

  carrier_gateway_id        = try(each.value.carrier_gateway_id, null)
  egress_only_gateway_id    = try(each.value.egress_only_gateway_id, null)
  gateway_id                = try(each.value.gateway_id, null)
  instance_id               = try(each.value.instance_id, null)
  local_gateway_id          = try(each.value.local_gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  network_interface_id      = try(each.value.network_interface_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}

resource "aws_route" "ipv6" {
  for_each = {
    for route in var.ipv6_routes :
    route.cidr => route
  }

  route_table_id              = aws_route_table.this.id
  destination_ipv6_cidr_block = each.key

  carrier_gateway_id        = try(each.value.carrier_gateway_id, null)
  egress_only_gateway_id    = try(each.value.egress_only_gateway_id, null)
  gateway_id                = try(each.value.gateway_id, null)
  instance_id               = try(each.value.instance_id, null)
  local_gateway_id          = try(each.value.local_gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  network_interface_id      = try(each.value.network_interface_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}

resource "aws_route" "prefix_list" {
  for_each = {
    for route in var.prefix_list_routes :
    route.id => route
  }

  route_table_id             = aws_route_table.this.id
  destination_prefix_list_id = each.key

  carrier_gateway_id        = try(each.value.carrier_gateway_id, null)
  egress_only_gateway_id    = try(each.value.egress_only_gateway_id, null)
  gateway_id                = try(each.value.gateway_id, null)
  instance_id               = try(each.value.instance_id, null)
  local_gateway_id          = try(each.value.local_gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  network_interface_id      = try(each.value.network_interface_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}


###################################################
# Associations
###################################################

# INFO: Conflict on create with `for_each`
resource "aws_route_table_association" "subnets" {
  count = length(var.subnets)

  route_table_id = aws_route_table.this.id
  subnet_id      = var.subnets[count.index]
}

resource "aws_route_table_association" "gateways" {
  for_each = toset(var.gateways)

  route_table_id = aws_route_table.this.id
  gateway_id     = each.value
}


###################################################
# VPC Gateway Endpoint Association
###################################################

resource "aws_vpc_endpoint_route_table_association" "this" {
  for_each = toset(var.vpc_gateway_endpoints)

  route_table_id  = aws_route_table.this.id
  vpc_endpoint_id = each.value
}


###################################################
# Route Propagations
###################################################

resource "aws_vpn_gateway_route_propagation" "this" {
  for_each = toset(var.propagating_vpn_gateways)

  route_table_id = aws_route_table.this.id
  vpn_gateway_id = each.value
}
