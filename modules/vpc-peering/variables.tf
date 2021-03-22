variable "name" {
  description = "Desired name for the VPC Peering resources."
  type        = string
}

variable "requester_vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "accepter_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection."
  type        = string
}

variable "requester_allow_remote_vpc_dns_resolution" {
  description = "Allow a requester VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the accepter VPC. This is not supported for inter-region VPC peering."
  type        = bool
  default     = false
}

variable "accepter_allow_remote_vpc_dns_resolution" {
  description = "Allow a accepter VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requester VPC. This is not supported for inter-region VPC peering."
  type        = bool
  default     = false
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
