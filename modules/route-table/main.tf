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


###################################################
# Route Table
###################################################

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_main_route_table_association" "this" {
  count = var.is_main ? 1 : 0

  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.this.id

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}


###################################################
# Associations
###################################################

resource "aws_route_table_association" "subnets" {
  count = length(var.subnets)

  route_table_id = aws_route_table.this.id
  subnet_id      = var.subnets[count.index]
}

resource "aws_route_table_association" "gateways" {
  count = length(var.gateways)

  route_table_id = aws_route_table.this.id
  gateway_id     = var.gateways[count.index]
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
