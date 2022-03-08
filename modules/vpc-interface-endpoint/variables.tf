variable "name" {
  description = "(Required) Desired name for the VPC Interface Endpoint."
  type        = string
}

variable "service_name" {
  description = "(Required) The service name. For AWS services the service name is usually in the form `com.amazonaws.<region>.<service>`."
  type        = string
}

variable "vpc_id" {
  description = "(Required) The ID of the VPC in which the endpoint will be used."
  type        = string
}

variable "subnets" {
  description = "(Required) The ID of one or more subnets in which to create a network interface for the endpoint."
  type        = list(string)
}

variable "private_dns_enabled" {
  description = "(Optional) Whether or not to associate a private hosted zone with the specified VPC."
  type        = bool
  default     = false
}

variable "default_security_group" {
  description = <<EOF
  (Optional) The configuration of the default security group for the interface endpoint. `default_security_group` block as defined below.
    (Optional) `name` - The name of the default security group.
    (Optional) `description` - The description of the default security group.
    (Optional) `ingress_cidrs` - A list of IPv4 CIDR blocks to allow inbound traffic from.
    (Optional) `ingress_ipv6_cidrs` - A list of IPv6 CIDR blocks to allow inbound traffic from.
    (Optional) `ingress_prefix_lists` - A list of Prefix List IDs to allow inbound traffic from.
    (Optional) `ingress_security_groups` - A list of source Security Group IDs to allow inbound traffic from.
  EOF
  type        = any
  default     = {}
}

variable "security_groups" {
  description = "(Optional) A set of security group IDs to associate with the network interface."
  type        = set(string)
  default     = []
}

variable "auto_accept" {
  description = "(Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account)."
  type        = bool
  default     = true
}

variable "policy" {
  description = "(Optional) A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access. All Gateway and some Interface endpoints support policies."
  type        = string
  default     = null
}

variable "notification_configurations" {
  description = "(Optional) A list of configurations of Endpoint Connection Notifications for VPC Endpoint events."
  type = list(object({
    sns_arn = string
    events  = list(string)
  }))
  default = []
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
}
