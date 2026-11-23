variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) The name of the security group."
  type        = string
  nullable    = false
}

# variable "name_prefix" {
#   description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with `name`."
#   type        = string
#   default     = null
#   nullable    = true
# }

variable "description" {
  description = "(Optional) The security group description. This field maps to the AWS `GroupDescription` attribute, for which there is no Update API."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "vpc_id" {
  description = "(Required) The ID of the associated VPC."
  type        = string
  nullable    = false
}

variable "revoke_rules_on_delete" {
  description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed."
  type        = bool
  default     = false
  nullable    = false
}

variable "ingress_rules" {
  description = <<EOF
  (Optional) The configuration for ingress rules of the security group. Each block of `ingress_rules` as defined below.
    (Required) `id` - The ID of the ingress rule. This value is only used internally within Terraform code.
    (Optional) `description` - The description of the rule.
    (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.
    (Optional) `from_port` - The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
    (Optional) `to_port` - The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.
    (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.
    (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.
    (Optional) `prefix_lists` - The prefix list IDs to allow.
    (Optional) `security_groups` - The source security group IDs to allow.
    (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule.
  EOF
  type = list(object({
    id              = string
    description     = optional(string, "Managed by Terraform.")
    protocol        = string
    from_port       = optional(number)
    to_port         = optional(number)
    ipv4_cidrs      = optional(list(string), [])
    ipv6_cidrs      = optional(list(string), [])
    prefix_lists    = optional(list(string), [])
    security_groups = optional(list(string), [])
    self            = optional(bool, false)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.ingress_rules :
      anytrue([
        length(rule.ipv4_cidrs) > 0,
        length(rule.ipv6_cidrs) > 0,
        length(rule.prefix_lists) > 0,
        length(rule.security_groups) > 0,
        rule.self,
      ])
    ])
    error_message = "At least one of `ipv4_cidrs`, `ipv6_cidrs`, `prefix_lists`, `security_groups` or `self` must be specified."
  }
}

variable "egress_rules" {
  description = <<EOF
  (Optional) The configuration for egress rules of the security group. Each block of `egress_rules` as defined below.
    (Required) `id` - The ID of the egress rule. This value is only used internally within Terraform code.
    (Optional) `description` - The description of the rule.
    (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.
    (Optional) `from_port` - The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
    (Optional) `to_port` - The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.
    (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.
    (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.
    (Optional) `prefix_lists` - The prefix list IDs to allow.
    (Optional) `security_groups` - The destination security group IDs to allow.
    (Optional) `self` - Whether the security group itself will be added as a destination to this egress rule.
  EOF
  type = list(object({
    id              = string
    description     = optional(string, "Managed by Terraform.")
    protocol        = string
    from_port       = optional(number)
    to_port         = optional(number)
    ipv4_cidrs      = optional(list(string), [])
    ipv6_cidrs      = optional(list(string), [])
    prefix_lists    = optional(list(string), [])
    security_groups = optional(list(string), [])
    self            = optional(bool, false)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.egress_rules :
      anytrue([
        length(rule.ipv4_cidrs) > 0,
        length(rule.ipv6_cidrs) > 0,
        length(rule.prefix_lists) > 0,
        length(rule.security_groups) > 0,
        rule.self,
      ])
    ])
    error_message = "At least one of `ipv4_cidrs`, `ipv6_cidrs`, `prefix_lists`, `security_groups` or `self` must be specified."
  }
}

variable "vpc_associations" {
  description = <<EOF
  (Optional) A set of VPC IDs to associate with the security group.
  EOF
  type        = set(string)
  default     = []
  nullable    = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module information."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group" {
  description = <<EOF
  (Optional) A configuration of Resource Group for this module. `resource_group` as defined below.
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


###################################################
# Resource Sharing by RAM (Resource Access Manager)
###################################################

variable "shares" {
  description = <<EOF
  (Optional) A list of resource shares via RAM (Resource Access Manager). Each block of `shares` as defined below.
    (Required) `name` - The name of the resource share. The name of the RAM resource share is generated with the name of the security group as a prefix.
    (Optional) `permissions` - A set of the names of the RAM permissions to associate with the resource share. Defaults to `["AWSRAMDefaultPermissionSecurityGroup"]`.
    (Optional) `external_principals_allowed` - Whether principals outside your organization can be associated with the resource share. Defaults to `false`.
    (Optional) `principals` - A set of principals to associate with the resource share. Possible values are an AWS account ID, an ARN of an organization in AWS Organizations, an ARN of an organizational unit (OU) in AWS Organizations, or an ARN of an IAM role or user. Defaults to `[]`.
    (Optional) `tags` - A map of tags to add to the resource share. Defaults to `{}`.
  EOF
  type = list(object({
    name = string

    permissions = optional(set(string), ["AWSRAMDefaultPermissionSecurityGroup"])

    external_principals_allowed = optional(bool, false)
    principals                  = optional(set(string), [])

    tags = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
