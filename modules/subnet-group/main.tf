locals {
  availability_zones = distinct(
    values(aws_subnet.this)[*].availability_zone
  )
  availability_zone_ids = distinct(
    values(aws_subnet.this)[*].availability_zone_id
  )
}

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id               = var.vpc_id
  availability_zone    = lookup(each.value, "availability_zone", null)
  availability_zone_id = lookup(each.value, "availability_zone_id", null)

  cidr_block      = lookup(each.value, "cidr_block", "")
  ipv6_cidr_block = lookup(each.value, "ipv6_cidr_block", null)

  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  outpost_arn                     = var.outpost_arn
  customer_owned_ipv4_pool        = var.customer_owned_ipv4_pool
  map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch

  tags = merge(
    {
      "Name" = format("%s", each.key)
    },
    var.tags,
  )
}


###################################################
# Subnet Groups for Managed Data Services
###################################################

resource "aws_db_subnet_group" "this" {
  count = var.db_subnet_group_enabled ? 1 : 0

  name       = var.db_subnet_group_name
  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = format("%s", var.db_subnet_group_name)
    },
    var.tags,
  )
}

resource "aws_elasticache_subnet_group" "this" {
  count = var.cache_subnet_group_enabled ? 1 : 0

  name       = var.cache_subnet_group_name
  subnet_ids = values(aws_subnet.this)[*].id

  # INFO: Not support resource tags
  # tags = {}
}

resource "aws_redshift_subnet_group" "this" {
  count = var.redshift_subnet_group_enabled ? 1 : 0

  name       = var.redshift_subnet_group_name
  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = format("%s", var.redshift_subnet_group_name)
    },
    var.tags,
  )
}

resource "aws_neptune_subnet_group" "this" {
  count = var.neptune_subnet_group_enabled ? 1 : 0

  name       = var.neptune_subnet_group_name
  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = format("%s", var.neptune_subnet_group_name)
    },
    var.tags,
  )
}

resource "aws_docdb_subnet_group" "this" {
  count = var.docdb_subnet_group_enabled ? 1 : 0

  name       = var.docdb_subnet_group_name
  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = format("%s", var.docdb_subnet_group_name)
    },
    var.tags,
  )
}

resource "aws_dax_subnet_group" "this" {
  count = var.dax_subnet_group_enabled ? 1 : 0

  name       = var.dax_subnet_group_name
  subnet_ids = values(aws_subnet.this)[*].id

  # INFO: Not support resource tags
  # tags = {}
}

resource "aws_dms_replication_subnet_group" "this" {
  count = var.dms_replication_subnet_group_enabled ? 1 : 0

  replication_subnet_group_id          = var.dms_replication_subnet_group_name
  replication_subnet_group_description = "Managed by Terraform"

  subnet_ids = values(aws_subnet.this)[*].id

  tags = merge(
    {
      "Name" = format("%s", var.dms_replication_subnet_group_name)
    },
    var.tags,
  )
}
