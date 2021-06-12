variable "name" {
  description = "Desired name for the NAT Gateway resources."
  type        = string
}

variable "is_private" {
  description = "Whether to create the gateway as private or public connectivity type. Defaults to public(false)."
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "The ID of the subnet which the NAT Gateway belongs to."
  type        = string
}

variable "assign_eip_on_create" {
  description = "Assign a new Elastic IP to NAT Gateway on create. Set false if you want to provide existing Elastic IP."
  type        = bool
  default     = false
}

variable "eip_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway. Create a new Elastic IP if not provided."
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
