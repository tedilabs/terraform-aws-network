variable "name" {
  description = "(Required) The name of the subnet group."
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = "(Required) The ID of the VPC which the subnet group belongs to."
  type        = string
  nullable    = false
}

variable "subnets" {
  description = <<EOF
  (Required) A configuration of subnets to create in the subnet group. Each block of `subnets` as defined below.
    (Required) `type` - The type of subnet. Valid values are `DUALSTACK` and `IPV6`.
    (Optional) `availability_zone` - The availability zone of the subnet. If the value of `availability_zone` and `availability_zone_id` are both not provided, the subnet will be created in random availability zone.
    (Optional) `availability_zone_id` - The availability zone ID of the subnet. If the value of `availability_zone` and `availability_zone_id` are both not provided, the subnet will be created in random availability zone.
  EOF
  type = map(object({
    type = optional(string, "DUALSTACK")

    availability_zone    = optional(string)
    availability_zone_id = optional(string)

    ipv4_cidr = optional(string)
    ipv6_cidr = optional(string)
  }))
  nullable = false

  validation {
    condition     = length(keys(var.subnets)) > 0
    error_message = "At least one subnet must be provided."
  }
  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      contains(["DUALSTACK", "IPV6"], subnet.type)
    ])
    error_message = "Valid values for `type` of each subnet are `DUALSTACK` and `IPV6`."
  }
  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      subnet.ipv4_cidr != null
      if subnet.type == "DUALSTACK"
    ])
    error_message = "IPv4 CIDR block must be provided for `DUALSTACK` subnet."
  }
  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      subnet.ipv6_cidr != null && subnet.ipv4_cidr == null
      if subnet.type == "IPV6"
    ])
    error_message = "IPv6 CIDR block must be provided for `IPV6` subnet."
  }
}

variable "local_network_interface_device_index" {
  description = <<EOF
  (Optional) The device position for local network interfaces in this subnet. For example, `1` indicates local network interfaces in this subnet are the secondary network interface (eth1). A local network interface cannot be the primary network interface (eth0).
  EOF
  type        = number
  default     = null
  nullable    = true
}

variable "public_ipv4_address_assignment" {
  description = <<EOF
  (Optional) A configuration for public IPv4 address assignment. `public_ipv4_address_assignment` as defined below.
    (Optional) `enabled` - Whether to automatically request a public IPv4 address for a new network interface in this subnet. Defaults to `false`.
  EOF
  type = object({
    enabled = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "customer_owned_ipv4_address_assignment" {
  description = <<EOF
  (Optional) A configuration for Customer-owned IPv4 address assignment. `customer_owned_ipv4_address_assignment` as defined below.
    (Optional) `enabled` - Whether to automatically request a Customer-owned IPv4 address for a new network interface in this subnet. Defaults to `false`.
    (Optional) `outpost` - The Amazon Resource Name (ARN) of the Outpost.
    (Optional) `pool` - The customer owned IPv4 address pool.
  EOF
  type = object({
    enabled = optional(bool, false)
    outpost = optional(string)
    pool    = optional(string)
  })
  default  = {}
  nullable = false
}

variable "ipv6_address_assignment" {
  description = <<EOF
  (Optional) A configuration for IPv6 address assignment. `ipv6_address_assignment` as defined below.
    (Optional) `enabled` - Whether to automatically request a IPv6 address for a new network interface in this subnet. Defaults to `false`.
  EOF
  type = object({
    enabled = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "dns_config" {
  description = <<EOF
  (Optional) A configuration for DNS queries for the subnet. `dns_config` as defined below.
    (Optional) `hostname_type` - The type of hostnames to assign to instances in the subnet at launch. For IPv6-only subnets, an instance DNS name must be based on the instance ID (`RESOURCE_NAME`). For dual-stack and IPv4-only subnets, you can specify whether DNS names use the instance IPv4 address (`IP_NAME`) or the instance ID (`RESOURCE_NAME`). Valid values are `IP_NAME`, `RESOURCE_NAME`. Defaults to `RESOURCE_NAME`.
    (Optional) `dns_resource_name_ipv4_enabled` - Whether to respond to DNS queries for instance hostnames with DNS A records. Always `false` for IPv6 only subnet. Defaults to `false`.
    (Optional) `dns_resource_name_ipv6_enabled` - Whether to respond to DNS queries for instance hostnames with DNS AAAA records. Always `true` for IPv6 only subnet. Defaults to `false`.
    (Optional) `dns64_enabled` - Whether to enable DNS64 to allow IPv6-only services in Amazon VPC to communicate with IPv4-only services and networks. Defaults to `false`.
  EOF
  type = object({
    hostname_type                  = optional(string, "RESOURCE_NAME")
    dns_resource_name_ipv4_enabled = optional(bool, false)
    dns_resource_name_ipv6_enabled = optional(bool, false)
    dns64_enabled                  = optional(bool, false)
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["IP_NAME", "RESOURCE_NAME"], var.dns_config.hostname_type)
    error_message = "Valid values for `hostname_type` are `IP_NAME` and `RESOURCE_NAME`."
  }
}

variable "dax_subnet_group" {
  description = <<EOF
  (Optional) A configuration of DAX Subnet Group. `dax_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create DAX Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the DAX Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the DAX Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "dms_replication_subnet_group" {
  description = <<EOF
  (Optional) A configuration of DMS Replication Subnet Group. `dms_replication_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create DMS Replication Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the DMS Replication Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the DMS Replication Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "docdb_subnet_group" {
  description = <<EOF
  (Optional) A configuration of DocumentDB Subnet Group. `docdb_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create DocumentDB Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the DocumentDB Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the DocumentDB Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "elasticache_subnet_group" {
  description = <<EOF
  (Optional) A configuration of ElastiCache Subnet Group. `elasticache_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create ElastiCache Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the ElastiCache Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the ElastiCache Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "memorydb_subnet_group" {
  description = <<EOF
  (Optional) A configuration of MemoryDB Subnet Group. `memorydb_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create MemoryDB Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the MemoryDB Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the MemoryDB Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "neptune_subnet_group" {
  description = <<EOF
  (Optional) A configuration of Neptune Subnet Group. `neptune_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create Neptune Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the Neptune Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the Neptune Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "rds_subnet_group" {
  description = <<EOF
  (Optional) A configuration of RDS Subnet Group. `rds_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create RDS Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the RDS Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the RDS Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "redshift_subnet_group" {
  description = <<EOF
  (Optional) A configuration of Redshift Subnet Group. `redshift_subnet_group` as defined below.
    (Optional) `enabled` - Whether to create Redshift Subnet Group. Defaults to `false`.
    (Optional) `name` - The name of the Redshift Subnet Group. If not provided, the value of `name` will be used.
    (Optional) `description` - The description of the Redshift Subnet Group.
  EOF
  type = object({
    enabled     = optional(bool, false)
    name        = optional(string)
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}

variable "timeouts" {
  description = "(Optional) How long to wait for the subnet group to be created/deleted."
  type = object({
    create = optional(string, "10m")
    delete = optional(string, "20m")
  })
  default  = {}
  nullable = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}


###################################################
# Resource Sharing by RAM (Resource Access Manager)
###################################################

variable "shares" {
  description = "(Optional) A list of resource shares via RAM (Resource Access Manager)."
  type = list(object({
    name = optional(string)

    permissions = optional(set(string), ["AWSRAMDefaultPermissionSubnet"])

    external_principals_allowed = optional(bool, false)
    principals                  = optional(set(string), [])

    tags = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
