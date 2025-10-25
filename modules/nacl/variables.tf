variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) Desired name for the network ACL resources."
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = "(Required) The ID of the VPC to associate."
  type        = string
  nullable    = false
}

variable "subnets" {
  description = "(Optional) A list of subnet IDs to apply the ACL to."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "ingress_rules" {
  description = <<EOF
  (Optional) A map of ingress rules in the default Network ACL. Use the key of map as the rule number (priority). If not explicitly defined, the AWS default rules are applied. Each block of `ingress_rules` as defined below.
    (Required) `priority` - The rule priority. The rule number. Used for ordering.
    (Required) `action` - The action to indicate whether to allow or deny the traffic that matches the rule. Valid values are `ALLOW` and `DENY`.
    (Required) `protocol` - The protocol to match. If using the `-1` `all` protocol, you must specify a from and to port of `0`.
    (Optional) `from_port` - The from port to match.
    (Optional) `to_port` - The to port to match.
    (Optional) `ipv4_cidr` - The IPv4 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv6_cidr`.
    (Optional) `ipv6_cidr` - The IPv6 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv4_cidr`.
    (Optional) `icmp_type` - The ICMP type to be used. Defaults to `0`.
    (Optional) `icmp_code` - The ICMP code to be used. Defaults to `0`.
  EOF
  type = map(object({
    action    = string
    protocol  = string
    from_port = optional(number)
    to_port   = optional(number)
    ipv4_cidr = optional(string)
    ipv6_cidr = optional(string)
    icmp_type = optional(number, 0)
    icmp_code = optional(number, 0)
  }))
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.ingress_rules :
      contains(["ALLOW", "DENY"], rule.action)
    ])
    error_message = "Valid values for `action` of each rules are `ALLOW` and `DENY`."
  }
}

variable "egress_rules" {
  description = <<EOF
  (Optional) A set of egress rules in the default Network ACL. Use the key of map as the rule number (priority). If not explicitly defined, the AWS default rules are applied. Each block of `egress_rules` as defined below.
    (Required) `priority` - The rule priority. The rule number. Used for ordering.
    (Required) `action` - The action to indicate whether to allow or deny the traffic that matches the rule. Valid values are `ALLOW` and `DENY`.
    (Required) `protocol` - The protocol to match. If using the `-1` 'all' protocol, you must specify a from and to port of `0`.
    (Optional) `from_port` - The from port to match.
    (Optional) `to_port` - The to port to match.
    (Optional) `ipv4_cidr` - The IPv4 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv6_cidr`.
    (Optional) `ipv6_cidr` - The IPv6 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv4_cidr`.
    (Optional) `icmp_type` - The ICMP type to be used. Defaults to `0`.
    (Optional) `icmp_code` - The ICMP code to be used. Defaults to `0`.
  EOF
  type = map(object({
    action    = string
    protocol  = string
    from_port = optional(number)
    to_port   = optional(number)
    ipv4_cidr = optional(string)
    ipv6_cidr = optional(string)
    icmp_type = optional(number, 0)
    icmp_code = optional(number, 0)
  }))
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.egress_rules :
      contains(["ALLOW", "DENY"], rule.action)
    ])
    error_message = "Valid values for `action` of each rules are `ALLOW` and `DENY`."
  }
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
