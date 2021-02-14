output "vpc_id" {
  description = "The ID of the VPC which the subnet group belongs to."
  value       = var.vpc_id
}

output "ids" {
  description = "A list of IDs of subnets"
  value       = values(aws_subnet.this)[*].id
}

output "arns" {
  description = "A list of ARNs of subnets"
  value       = values(aws_subnet.this)[*].arn
}

output "cidr_blocks" {
  description = "The CIDR blocks of the subnet group."
  value       = values(aws_subnet.this)[*].cidr_block
}

output "ipv6_cidr_blocks" {
  description = "The IPv6 CIDR blocks of the subnet group."
  value       = values(aws_subnet.this)[*].ipv6_cidr_block
}

output "availability_zones" {
  description = "A list of availability zones which the subnet group uses."
  value       = local.availability_zones
}

output "availability_zone_ids" {
  description = "A list of availability zone IDs which the subnet group uses."
  value       = local.availability_zone_ids
}

output "subnets" {
  description = "A list of subnets."
  value       = values(aws_subnet.this)
}

output "db_subnet_group_id" {
  description = "The ID of the RDS Subnet Group."
  value       = element(concat(aws_db_subnet_group.this.*.id, [""]), 0)
}

output "db_subnet_group_arn" {
  description = "The ARN of the RDS Subnet Group."
  value       = element(concat(aws_db_subnet_group.this.*.arn, [""]), 0)
}

output "cache_subnet_group_id" {
  description = "The ID of the Elasticache Subnet Group."
  value       = element(concat(aws_elasticache_subnet_group.this.*.id, [""]), 0)
}

# INFO: Not support arn output
# output "cache_subnet_group_arn" {
#   description = "The ARN of the Elasticache Subnet Group."
#   value       = element(concat(aws_elasticache_subnet_group.this.*.arn, [""]), 0)
# }

output "redshift_subnet_group_id" {
  description = "The ID of the Redshift Subnet Group."
  value       = element(concat(aws_redshift_subnet_group.this.*.id, [""]), 0)
}

output "redshift_subnet_group_arn" {
  description = "The ARN of the Redshift Subnet Group."
  value       = element(concat(aws_redshift_subnet_group.this.*.arn, [""]), 0)
}

output "neptune_subnet_group_id" {
  description = "The ID of the Neptune DB Subnet Group."
  value       = element(concat(aws_neptune_subnet_group.this.*.id, [""]), 0)
}

output "neptune_subnet_group_arn" {
  description = "The ARN of the Neptune Subnet Group."
  value       = element(concat(aws_neptune_subnet_group.this.*.arn, [""]), 0)
}

output "docdb_subnet_group_id" {
  description = "The ID of the DocumentDB Subnet Group."
  value       = element(concat(aws_docdb_subnet_group.this.*.id, [""]), 0)
}

output "docdb_subnet_group_arn" {
  description = "The ARN of the DocumentDB Subnet Group."
  value       = element(concat(aws_docdb_subnet_group.this.*.arn, [""]), 0)
}

output "dax_subnet_group_id" {
  description = "The ID of the DAX Subnet Group."
  value       = element(concat(aws_dax_subnet_group.this.*.id, [""]), 0)
}

# INFO: Not support arn output
# output "dax_subnet_group_arn" {
#   description = "The ARN of the DAX Subnet Group."
#   value       = element(concat(aws_dax_subnet_group.this.*.arn, [""]), 0)
# }

output "dms_replication_subnet_group_id" {
  description = "The ID of the DMS Replication Subnet Group."
  value       = element(concat(aws_dms_replication_subnet_group.this.*.id, [""]), 0)
}

# INFO: Not support arn output
# output "dms_replication_subnet_group_arn" {
#   description = "The ARN of the DMS Replication Subnet Group."
#   value       = element(concat(aws_dms_replication_subnet_group.this.*.arn, [""]), 0)
# }
