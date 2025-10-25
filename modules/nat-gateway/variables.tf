variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) Desired name for the NAT Gateway resources."
  type        = string
  nullable    = false
}

variable "is_private" {
  description = "(Optional) Whether to create the NAT gateway as private or public connectivity type. Defaults to `false` (public)."
  type        = bool
  default     = false
  nullable    = false
}

variable "subnet" {
  description = "(Required) The Subnet ID of the subnet in which to place the NAT Gateway."
  type        = string
  nullable    = false
}

variable "public_ip_assignments" {
  description = <<EOF
  (Optional) A configuration to assign public ip addresses with the NAT Gateway. `public_ip_assignments` as defined below.
    (Optional) `primary_elastic_ip` - The allocation ID of Elastic IP address to associate with the NAT Gateway.
    (Optional) `secondary_elastic_ips` - A set of allocation IDs of Elastic IP addresses to associate with the NAT Gateway as secondary IPs.
  EOF
  type = object({
    primary_elastic_ip    = optional(string)
    secondary_elastic_ips = optional(set(string), [])
  })
  default  = {}
  nullable = false

  validation {
    condition = anytrue([
      var.is_private,
      !var.is_private && var.public_ip_assignments.primary_elastic_ip != null
    ])
    error_message = "`primary_elastic_ip` must be provided for public NAT Gateway."
  }
}

variable "private_ip_assignments" {
  description = <<EOF
  (Optional) A configuration to assign private ip addresses with the NAT Gateway. `private_ip_assignments` as defined below.
    (Optional) `primary_private_ip` - The private IP address to associate with the NAT Gateway. If you dont't provide an address, a private IPv4 address will be automatically assigned.
    (Optional) `secondary_private_ips` - A set of secondary private IPv4 addresses to assign to the NAT Gateway.
    (Optional) `secondary_private_ip_count` - The number of secondary private IPv4 addresses to assign to the NAT Gateway.
  EOF
  type = object({
    primary_private_ip         = optional(string)
    secondary_private_ips      = optional(set(string), [])
    secondary_private_ip_count = optional(number, 0)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      var.private_ip_assignments.secondary_private_ip_count >= 0,
      var.private_ip_assignments.secondary_private_ip_count <= 32,
    ])
    error_message = "`secondary_private_ip_count` must be between 0 and 32."
  }
}

variable "timeouts" {
  description = "(Optional) How long to wait for the NAT Gateway to be created/updated/deleted."
  type = object({
    create = optional(string, "10m")
    update = optional(string, "10m")
    delete = optional(string, "30m")
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

variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
