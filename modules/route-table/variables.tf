variable "name" {
  description = "Desired name for the route table resources."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC which the route table belongs to."
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the route table."
  type        = list(string)
  default     = []
}

variable "gateways" {
  description = "A list of gateway IDs to associate with the route table. Only support Internet Gateway and Virtual Private Gateway."
  type        = list(string)
  default     = []
}

variable "vpc_gateway_endpoints" {
  description = "A list of the VPC Endpoint IDs with which the Route Table will be associated."
  type        = list(string)
  default     = []
}

variable "propagating_vpn_gateways" {
  description = "A list of Virtual Private Gateway IDs to propagate routes from."
  type        = list(string)
  default     = []
}

variable "is_main" {
  description = "Whether to set this route table as the main route table."
  type        = bool
  default     = false
}

variable "ipv4_routes" {
  description = "A list of route rules for IPv4 CIDRs."
  type        = list(map(string))
  default     = []
}

variable "ipv6_routes" {
  description = "A list of route rules for IPv6 CIDRs."
  type        = list(map(string))
  default     = []
}

variable "prefix_list_routes" {
  description = "A list of route rules for Managed Prefix List."
  type        = list(map(string))
  default     = []
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
