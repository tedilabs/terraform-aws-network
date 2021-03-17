variable "name" {
  description = "Desired name for the network ACL resources."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the associated VPC."
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to apply the ACL to."
  type        = list(string)
  default     = []
}

variable "ingress_rules" {
  description = "A map of ingress rules in a network ACL. Use the key of map as the rule number."
  type        = map(map(any))
  default     = {}
}

variable "egress_rules" {
  description = "A map of egress rules in a network ACL. Use the key of map as the rule number."
  type        = map(map(any))
  default     = {}
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
