###################################################
# Subnet Group for DAX
###################################################

resource "aws_dax_subnet_group" "this" {
  count = var.dax_subnet_group.enabled ? 1 : 0

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
