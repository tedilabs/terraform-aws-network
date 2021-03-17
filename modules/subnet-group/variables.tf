variable "name" {
  description = "The name of the subnet group."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC which the subnet group belongs to."
  type        = string
}

variable "subnets" {
  description = "A map of subnet parameters to create subnets for the subnet group."
  type        = map(map(any))
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch."
  type        = bool
  default     = false
}

variable "assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch."
  type        = bool
  default     = false
}

variable "outpost_arn" {
  description = "The ARN of the Outpost."
  type        = string
  default     = ""
}

variable "customer_owned_ipv4_pool" {
  description = "The customer owned IPv4 address pool. `outpost_arn` argument must be specified when configured."
  type        = string
  default     = ""
}

variable "map_customer_owned_ip_on_launch" {
  description = "Should be true if network interfaces created in the subnet should be assigned a customer owned IP address."
  type        = bool
  default     = false
}

variable "db_subnet_group_enabled" {
  description = "Controls if RDS Subnet Group should be created."
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Desired name for the RDS Subnet Group."
  type        = string
  default     = ""
}

variable "cache_subnet_group_enabled" {
  description = "Controls if Elasticache Subnet Group should be created."
  type        = bool
  default     = false
}

variable "cache_subnet_group_name" {
  description = "Desired name for the Elasticache Subnet Group."
  type        = string
  default     = ""
}

variable "redshift_subnet_group_enabled" {
  description = "Controls if Redshift Subnet Group should be created."
  type        = bool
  default     = false
}

variable "redshift_subnet_group_name" {
  description = "Desired name for the Redshift Subnet Group."
  type        = string
  default     = ""
}

variable "neptune_subnet_group_enabled" {
  description = "Controls if Neptune Subnet Group should be created."
  type        = bool
  default     = false
}

variable "neptune_subnet_group_name" {
  description = "Desired name for the Neptune Subnet Group."
  type        = string
  default     = ""
}

variable "docdb_subnet_group_enabled" {
  description = "Controls if DocumentDB Subnet Group should be created."
  type        = bool
  default     = false
}

variable "docdb_subnet_group_name" {
  description = "Desired name for the DocumentDB Subnet Group."
  type        = string
  default     = ""
}

variable "dax_subnet_group_enabled" {
  description = "Controls if DAX Subnet Group should be created."
  type        = bool
  default     = false
}

variable "dax_subnet_group_name" {
  description = "Desired name for the DAX Subnet Group."
  type        = string
  default     = ""
}

variable "dms_replication_subnet_group_enabled" {
  description = "Controls if DMS Replication Subnet Group should be created."
  type        = bool
  default     = false
}

variable "dms_replication_subnet_group_name" {
  description = "Desired name for the DMS Replication Subnet Group."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "module_tags_enabled" {
  description = "Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
}

variable "resource_group_description" {
  description = "The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
}
