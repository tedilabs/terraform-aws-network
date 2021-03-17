locals {
  metadata = {
    package = basename(dirname(dirname(path.module)))
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

  egress_only_gateway_id    = lookup(each.value, "egress_only_gateway_id", "")
  gateway_id                = lookup(each.value, "gateway_id", "")
  instance_id               = lookup(each.value, "instance_id", "")
  local_gateway_id          = lookup(each.value, "local_gateway_id", "")
  nat_gateway_id            = lookup(each.value, "nat_gateway_id", "")
  network_interface_id      = lookup(each.value, "network_interface_id", "")
  transit_gateway_id        = lookup(each.value, "transit_gateway_id", "")
  vpc_endpoint_id           = lookup(each.value, "vpc_endpoint_id", "")
  vpc_peering_connection_id = lookup(each.value, "vpc_peering_connection_id", "")
}

resource "aws_route" "ipv6" {
  for_each = {
    for route in var.ipv6_routes :
    route.cidr => route
  }

  route_table_id              = aws_route_table.this.id
  destination_ipv6_cidr_block = each.key

  egress_only_gateway_id    = lookup(each.value, "egress_only_gateway_id", "")
  gateway_id                = lookup(each.value, "gateway_id", "")
  instance_id               = lookup(each.value, "instance_id", "")
  local_gateway_id          = lookup(each.value, "local_gateway_id", "")
  nat_gateway_id            = lookup(each.value, "nat_gateway_id", "")
  network_interface_id      = lookup(each.value, "network_interface_id", "")
  transit_gateway_id        = lookup(each.value, "transit_gateway_id", "")
  vpc_endpoint_id           = lookup(each.value, "vpc_endpoint_id", "")
  vpc_peering_connection_id = lookup(each.value, "vpc_peering_connection_id", "")
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
# Route Propagations
###################################################

resource "aws_vpn_gateway_route_propagation" "this" {
  for_each = toset(var.propagating_vpn_gateways)

  route_table_id = aws_route_table.this.id
  vpn_gateway_id = each.value
}
