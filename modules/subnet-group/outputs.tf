output "region" {
  description = "The AWS region this module resources resides in."
  value       = values(aws_subnet.this)[0].region
}

output "name" {
  description = "The name of the subnet group."
  value       = var.name
}

output "vpc_id" {
  description = "The ID of the VPC which the subnet group belongs to."
  value       = values(aws_subnet.this)[0].vpc_id
}

output "ids" {
  description = "A list of IDs of subnets"
  value       = values(aws_subnet.this)[*].id
}

output "arns" {
  description = "A list of ARNs of subnets"
  value       = values(aws_subnet.this)[*].arn
}

output "owner_id" {
  description = "The ID of the AWS account that owns subnets in the subnet group."
  value       = values(aws_subnet.this)[0].owner_id
}

output "ipv4_cidrs" {
  description = "The IPv4 CIDR blocks of the subnet group."
  value       = compact(values(aws_subnet.this)[*].cidr_block)
}

output "ipv6_cidrs" {
  description = "The IPv6 CIDR blocks of the subnet group."
  value       = compact(values(aws_subnet.this)[*].ipv6_cidr_block)
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
  description = "A list of subnets of the subnet group."
  value       = local.subnets
}

output "subnets_by_az" {
  description = "A map of subnets of the subnet group which are grouped by availability zone id."
  value = {
    for subnet in local.subnets :
    subnet.availability_zone_id => subnet...
  }
}

output "local_network_interface_device_index" {
  description = "The device position for local network interfaces in this subnet."
  value       = var.local_network_interface_device_index
}

output "public_ipv4_address_assignment" {
  description = <<EOF
  The configuration of public IPv4 address assignment.
    `enabled` - Whether to automatically assign public IPv4 address to instances launched in the subnet group.
  EOF
  value = {
    enabled = values(aws_subnet.this)[0].map_public_ip_on_launch
  }
}

output "customer_owned_ipv4_address_assignment" {
  description = <<EOF
  The configuration of Customer-owned IPv4 address assignment.
    `enabled` - Whether to automatically assign Customer-owned IPv4 address to instances launched in the subnet group.
    `outpost` - The ARN of the Outpost.
    `pool` - The ID of the Customer-owned IPv4 address pool.
  EOF
  value = {
    enabled = values(aws_subnet.this)[0].map_public_ip_on_launch
    outpost = values(aws_subnet.this)[0].outpost_arn
    pool    = values(aws_subnet.this)[0].customer_owned_ipv4_pool
  }
}

output "ipv6_address_assignment" {
  description = <<EOF
  The configuration of IPv6 address assignment.
    `enabled` - Whether to automatically assign IPv6 address to instances launched in the subnet group.
  EOF
  value = {
    enabled = values(aws_subnet.this)[0].assign_ipv6_address_on_creation
  }
}

output "dns_config" {
  description = <<EOF
  The DNS configuration for the subnet group.
    `id` - The ID of the DAX Subnet Group.
  EOF
  value = {
    hostname_type = {
      for k, v in local.hostname_types :
      v => k
    }[values(aws_subnet.this)[0].private_dns_hostname_type_on_launch]
    dns_resource_name_ipv4_enabled = values(aws_subnet.this)[0].enable_resource_name_dns_a_record_on_launch
    dns_resource_name_ipv6_enabled = values(aws_subnet.this)[0].enable_resource_name_dns_aaaa_record_on_launch
    dns64_enabled                  = values(aws_subnet.this)[0].enable_dns64
  }
}

output "block_public_access_exclusion_mode" {
  description = "The block public access exclusion mode for the subnet group."
  value = (length(aws_vpc_block_public_access_exclusion.this) != 0
    ? {
      for k, v in local.block_public_access_exclusion_mode :
      v => k
    }[values(aws_vpc_block_public_access_exclusion.this)[0].internet_gateway_exclusion_mode]
    : "OFF"
  )
}

output "transit_gateway_attachments" {
  description = <<EOF
  The configuration of Transit Gateway VPC attachments.
  EOF
  value = {
    for name, attachment in aws_ec2_transit_gateway_vpc_attachment.this :
    name => {
      name            = name
      transit_gateway = attachment.transit_gateway_id

      appliance_mode_enabled                  = attachment.appliance_mode_support == "enable"
      dns_support_enabled                     = attachment.dns_support == "enable"
      ipv6_enabled                            = attachment.ipv6_support == "enable"
      default_association_route_table_enabled = attachment.transit_gateway_default_route_table_association
      default_propagation_route_table_enabled = attachment.transit_gateway_default_route_table_propagation
    }
  }
}

output "dax_subnet_group" {
  description = <<EOF
  The configuration of DAX Subnet Group.
    `id` - The ID of the DAX Subnet Group.
    `name` - The name of the DAX Subnet Group.
    `description` - The description of the DAX Subnet Group.
  EOF
  value = (var.dax_subnet_group.enabled
    ? {
      id = one(aws_dax_subnet_group.this[*].id)
      # INFO: Not support arn output
      # arn         = one(aws_dax_subnet_group.this[*])
      name        = one(aws_dax_subnet_group.this[*].name)
      description = one(aws_dax_subnet_group.this[*].description)
    }
    : null
  )
}

output "dms_replication_subnet_group" {
  description = <<EOF
  The configuration of DMS Replication Subnet Group.
    `id` - The ID of the DMS Replication Subnet Group.
    `arn` - The ARN of the DMS Replication Subnet Group.
    `name` - The name of the DMS Replication Subnet Group.
    `description` - The description of the DMS Replication Subnet Group.
  EOF
  value = (var.dms_replication_subnet_group.enabled
    ? {
      id          = one(aws_dms_replication_subnet_group.this[*].id)
      arn         = one(aws_dms_replication_subnet_group.this[*].replication_subnet_group_arn)
      name        = one(aws_dms_replication_subnet_group.this[*].replication_subnet_group_id)
      description = one(aws_dms_replication_subnet_group.this[*].replication_subnet_group_description)
    }
    : null
  )
}

output "docdb_subnet_group" {
  description = <<EOF
  The configuration of DocumentDB Subnet Group.
    `id` - The ID of the DocumentDB Subnet Group.
    `arn` - The ARN of the DocumentDB Subnet Group.
    `name` - The name of the DocumentDB Subnet Group.
    `description` - The description of the DocumentDB Subnet Group.
  EOF
  value = (var.docdb_subnet_group.enabled
    ? {
      id          = one(aws_docdb_subnet_group.this[*].id)
      arn         = one(aws_docdb_subnet_group.this[*].arn)
      name        = one(aws_docdb_subnet_group.this[*].name)
      description = one(aws_docdb_subnet_group.this[*].description)
    }
    : null
  )
}

output "elasticache_subnet_group" {
  description = <<EOF
  The configuration of ElastiCache Subnet Group.
    `id` - The ID of the ElastiCache Subnet Group.
    `arn` - The ARN of the ElastiCache Subnet Group.
    `name` - The name of the ElastiCache Subnet Group.
    `description` - The description of the ElastiCache Subnet Group.
  EOF
  value = (var.elasticache_subnet_group.enabled
    ? {
      id          = one(aws_elasticache_subnet_group.this[*].id)
      arn         = one(aws_elasticache_subnet_group.this[*].arn)
      name        = one(aws_elasticache_subnet_group.this[*].name)
      description = one(aws_elasticache_subnet_group.this[*].description)
    }
    : null
  )
}

output "memorydb_subnet_group" {
  description = <<EOF
  The configuration of MemoryDB Subnet Group.
    `id` - The ID of the MemoryDB Subnet Group.
    `arn` - The ARN of the MemoryDB Subnet Group.
    `name` - The name of the MemoryDB Subnet Group.
    `description` - The description of the MemoryDB Subnet Group.
  EOF
  value = (var.memorydb_subnet_group.enabled
    ? {
      id          = one(aws_memorydb_subnet_group.this[*].id)
      arn         = one(aws_memorydb_subnet_group.this[*].arn)
      name        = one(aws_memorydb_subnet_group.this[*].name)
      description = one(aws_memorydb_subnet_group.this[*].description)
    }
    : null
  )
}

output "neptune_subnet_group" {
  description = <<EOF
  The configuration of Neptune Subnet Group.
    `id` - The ID of the Neptune Subnet Group.
    `arn` - The ARN of the Neptune Subnet Group.
    `name` - The name of the Neptune Subnet Group.
    `description` - The description of the Neptune Subnet Group.
  EOF
  value = (var.neptune_subnet_group.enabled
    ? {
      id          = one(aws_neptune_subnet_group.this[*].id)
      arn         = one(aws_neptune_subnet_group.this[*].arn)
      name        = one(aws_neptune_subnet_group.this[*].name)
      description = one(aws_neptune_subnet_group.this[*].description)
    }
    : null
  )
}

output "rds_subnet_group" {
  description = <<EOF
  The configuration of RDS Subnet Group.
    `id` - The ID of the RDS Subnet Group.
    `arn` - The ARN of the RDS Subnet Group.
    `name` - The name of the RDS Subnet Group.
    `description` - The description of the RDS Subnet Group.
  EOF
  value = (var.rds_subnet_group.enabled
    ? {
      id          = one(aws_db_subnet_group.this[*].id)
      arn         = one(aws_db_subnet_group.this[*].arn)
      name        = one(aws_db_subnet_group.this[*].name)
      description = one(aws_db_subnet_group.this[*].description)
    }
    : null
  )
}

output "redshift_subnet_group" {
  description = <<EOF
  The configuration of Redshift Subnet Group.
    `id` - The ID of the Redshift Subnet Group.
    `arn` - The ARN of the Redshift Subnet Group.
    `name` - The name of the Redshift Subnet Group.
    `description` - The description of the Redshift Subnet Group.
  EOF
  value = (var.redshift_subnet_group.enabled
    ? {
      id          = one(aws_redshift_subnet_group.this[*].id)
      arn         = one(aws_redshift_subnet_group.this[*].arn)
      name        = one(aws_redshift_subnet_group.this[*].name)
      description = one(aws_redshift_subnet_group.this[*].description)
    }
    : null
  )
}

output "sharing" {
  description = <<EOF
  The configuration for sharing of subnets in the subnet group.
    `status` - An indication of whether subnets are shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`.
    `shares` - The list of resource shares via RAM (Resource Access Manager).
  EOF
  value = {
    status = length(module.share) > 0 ? "SHARED_BY_ME" : "NOT_SHARED"
    shares = module.share
  }
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
