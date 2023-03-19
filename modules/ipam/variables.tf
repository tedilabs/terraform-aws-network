variable "name" {
  description = "(Required) The name of the IPAM."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description for the IPAM."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "operating_regions" {
  description = <<EOF
  (Optional) A set of operating regions for the IPAM. Operating Regions are AWS Regions where the IPAM is allowed to manage IP address CIDRs. IPAM only discovers and monitors resources in the AWS Regions you select as operating Regions. The current region is required to include.
  EOF
  type        = set(string)
  default     = []
  nullable    = false
}

variable "cascade_deletion_enabled" {
  description = "(Optional) Whether to enable you to quickly delete an IPAM, private scopes, pools in private scopes, and any allocations in the pools in private scopes. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "additional_private_scopes" {
  description = <<EOF
  (Optional) A list of additional scopes to create and manage by the IPAM. A scope is the highest-level container within IPAM. When you create an IPAM, IPAM creates two default scopes for you. Each scope represents the IP space for a single network. Each block of `additional_scopes` as defined below.
    (Required) `name` - A name of the scope in the IPAM.
    (Optional) `description` - A description of the scope in the IPAM.
  EOF
  type = list(object({
    name        = string
    description = optional(string, "Managed by Terraform.")
  }))
  default  = []
  nullable = false
}

variable "additional_resource_discovery_associations" {
  description = <<EOF
  (Optional) A list of additional associations to an IPAM resource discovery with an Amazon VPC IPAM. A resource discovery is an IPAM component that enables IPAM to manage and monitor resources that belong to the owning account. Each block of `additional_resource_discovery_associations` as defined below.
    (Required) `resource_discovery` - The ID of the Resource Discovery to associate.
    (Optional) `tags` - A map of tags to add to the IPAM resource discovery association resource.
  EOF
  type = list(object({
    resource_discovery = string
    tags               = optional(map(string), {})
  }))
  default  = []
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
