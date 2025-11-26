data "aws_caller_identity" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id
}


###################################################
# VPC Attachments for Transit Gateway
###################################################

data "aws_ec2_transit_gateway" "this" {
  for_each = {
    for attachment in var.transit_gateway_attachments :
    attachment.name => attachment.transit_gateway
  }

  region = var.region

  filter {
    name   = "transit-gateway-id"
    values = [each.value]
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each = {
    for attachment in var.transit_gateway_attachments :
    attachment.name => attachment
  }

  region = var.region

  vpc_id     = var.vpc_id
  subnet_ids = values(aws_subnet.this)[*].id

  transit_gateway_id = each.value.transit_gateway

  appliance_mode_support             = each.value.appliance_mode_enabled ? "enable" : "disable"
  dns_support                        = each.value.dns_support_enabled ? "enable" : "disable"
  ipv6_support                       = each.value.ipv6_enabled ? "enable" : "disable"
  security_group_referencing_support = each.value.security_group_referencing_enabled ? "enable" : "disable"

  transit_gateway_default_route_table_association = (local.account_id == data.aws_ec2_transit_gateway.this[each.key].owner_id
    ? each.value.default_association_route_table_enabled
    : null
  )
  transit_gateway_default_route_table_propagation = (local.account_id == data.aws_ec2_transit_gateway.this[each.key].owner_id
    ? each.value.default_propagation_route_table_enabled
    : null
  )

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
    each.value.tags,
  )
}


###################################################
# Subnet Group for DAX
###################################################

resource "aws_dax_subnet_group" "this" {
  count = var.dax_subnet_group.enabled ? 1 : 0

  region = var.region

  name        = coalesce(var.dax_subnet_group.name, var.name)
  description = var.dax_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  # INFO: Not support resource tags
  # tags = {}
}


###################################################
# Subnet Group for DMS Replication
###################################################

resource "aws_dms_replication_subnet_group" "this" {
  count = var.dms_replication_subnet_group.enabled ? 1 : 0

  region = var.region

  replication_subnet_group_id          = coalesce(var.dms_replication_subnet_group.name, var.name)
  replication_subnet_group_description = var.dms_replication_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = coalesce(var.dms_replication_subnet_group.name, var.name)
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Subnet Group for DocumentDB
###################################################

resource "aws_docdb_subnet_group" "this" {
  count = var.docdb_subnet_group.enabled ? 1 : 0

  region = var.region

  name        = coalesce(var.docdb_subnet_group.name, var.name)
  description = var.docdb_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = coalesce(var.docdb_subnet_group.name, var.name)
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Subnet Group for ElastiCache
###################################################

resource "aws_elasticache_subnet_group" "this" {
  count = var.elasticache_subnet_group.enabled ? 1 : 0

  region = var.region

  name        = coalesce(var.elasticache_subnet_group.name, var.name)
  description = var.elasticache_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = coalesce(var.elasticache_subnet_group.name, var.name)
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Subnet Group for MemoryDB
###################################################

resource "aws_memorydb_subnet_group" "this" {
  count = var.memorydb_subnet_group.enabled ? 1 : 0

  region = var.region

  name        = coalesce(var.memorydb_subnet_group.name, var.name)
  description = var.memorydb_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = coalesce(var.memorydb_subnet_group.name, var.name)
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Subnet Group for Neptune
###################################################

resource "aws_neptune_subnet_group" "this" {
  count = var.neptune_subnet_group.enabled ? 1 : 0

  region = var.region

  name        = coalesce(var.neptune_subnet_group.name, var.name)
  description = var.neptune_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = coalesce(var.neptune_subnet_group.name, var.name)
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Subnet Group for RDS
###################################################

resource "aws_db_subnet_group" "this" {
  count = var.rds_subnet_group.enabled ? 1 : 0

  region = var.region

  name        = coalesce(var.rds_subnet_group.name, var.name)
  description = var.rds_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = coalesce(var.rds_subnet_group.name, var.name)
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Subnet Group for Redshift
###################################################

resource "aws_redshift_subnet_group" "this" {
  count = var.redshift_subnet_group.enabled ? 1 : 0

  region = var.region

  name        = coalesce(var.redshift_subnet_group.name, var.name)
  description = var.redshift_subnet_group.description

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = coalesce(var.redshift_subnet_group.name, var.name)
    },
    local.module_tags,
    var.tags,
  )
}
