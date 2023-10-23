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

variable "primary_ip_assignment" {
  description = <<EOF
  (Optional) A configuration to assign primary ip address with the NAT Gateway. `primary_ip_assignment` as defined below.
    (Optional) `elastic_ip` - The allocation ID of Elastic IP address to associate with the NAT Gateway.
    (Optional) `private_ip` - The private IP address to associate with the NAT Gateway. If you dont't provide an address, a private IPv4 address will be automatically assigned.
  EOF
  type = object({
    elastic_ip = optional(string)
    private_ip = optional(string)
  })
  default  = {}
  nullable = false
}

variable "secondary_ip_assignments" {
  description = <<EOF
  (Optional) A configuration to assign secondary ip addresses with the NAT Gateway. Each block of `secondary_ip_assignments` as defined below.
    (Optional) `elastic_ip` - The allocation ID of Elastic IP address to associate with the NAT Gateway.
    (Optional) `private_ip` - The private IP address to associate with the NAT Gateway. If you dont't provide an address, a private IPv4 address will be automatically assigned.
  EOF
  type = list(object({
    elastic_ip = optional(string)
    private_ip = optional(string)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for assignment in var.secondary_ip_assignments : (
        assignment.elastic_ip != null || assignment.private_ip != null
      )
    ])
    error_message = "Either `elastic_ip` or `private_ip` must be provided."
  }
}

variable "secondary_ip_count" {
  description = <<EOF
  (Optional) The number of secondary private IPv4 addresses to assign to the NAT Gateway. Only used with private NAT Gateway.
  EOF
  type        = number
  default     = null
  nullable    = true

  validation {
    condition = (var.secondary_ip_count != null
      ? var.secondary_ip_count > 0 && var.secondary_ip_count < 32
      : true
    )
    error_message = "`secondary_ip_count` must be greater than 0 and less than 32."
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
