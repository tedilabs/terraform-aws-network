variable "name" {
  description = "(Required) Desired name for the route table resources."
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = "(Required) The ID of the VPC which the route table belongs to."
  type        = string
  nullable    = false
}

variable "is_main" {
  description = "(Optional) Whether to set this route table as the main route table. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "subnets" {
  description = "(Optional) A list of subnet IDs to associate with the route table."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "gateways" {
  description = "(Optional) A list of gateway IDs to associate with the route table. Only support Internet Gateway and Virtual Private Gateway."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "vpc_gateway_endpoints" {
  description = "(Optional) A list of the VPC Endpoint IDs with which the Route Table will be associated."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "propagating_vpn_gateways" {
  description = "(Optional) A list of Virtual Private Gateway IDs to propagate routes from."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "ipv4_routes" {
  description = <<EOF
  (Optional) A list of route rules for destinations to IPv4 CIDRs. Each block of `ipv4_routes` as defined below.
    (Required) `destination` - The destination IPv4 CIDR block of the route rule.
    (Required) `target` - A configuration of the target of the route rule. `target` as defined below.
      (Required) `type` - The type of the target of the route rule. Valid values are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`.
      (Required) `id` - The ID of the target of the route rule.
  EOF
  type = list(object({
    destination = string

    target = object({
      type = string
      id   = string
    })
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for route in var.ipv4_routes :
      contains(["CARRIER_GATEWAY", "CORE_GATEWAY", "EGRESS_ONLY_INTERNET_GATEWAY", "INTERNET_GATEWAY", "VPN_GATEWAY", "LOCAL_GATEWAY", "NAT_GATEWAY", "NETWORK_INTERFACE", "TRANSIT_GATEWAY", "VPC_ENDPOINT", "VPC_PEERING_CONNECTION"], route.target.type)
    ])
    error_message = "Valid values for `type` are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`."
  }
}

variable "ipv6_routes" {
  description = <<EOF
  (Optional) A list of route rules for destinations to IPv6 CIDRs. Each block of `ipv6_routes` as defined below.
    (Required) `destination` - The destination IPv6 CIDR block of the route rule.
    (Required) `target` - A configuration of the target of the route rule. `target` as defined below.
      (Required) `type` - The type of the target of the route rule. Valid values are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`.
      (Required) `id` - The ID of the target of the route rule.
  EOF
  type = list(object({
    destination = string

    target = object({
      type = string
      id   = string
    })
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for route in var.ipv6_routes :
      contains(["CARRIER_GATEWAY", "CORE_GATEWAY", "EGRESS_ONLY_INTERNET_GATEWAY", "INTERNET_GATEWAY", "VPN_GATEWAY", "LOCAL_GATEWAY", "NAT_GATEWAY", "NETWORK_INTERFACE", "TRANSIT_GATEWAY", "VPC_ENDPOINT", "VPC_PEERING_CONNECTION"], route.target.type)
    ])
    error_message = "Valid values for `type` are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`."
  }
}

variable "prefix_list_routes" {
  description = <<EOF
  (Optional) A list of route rules for destinations to Prefix Lists. Each block of `prefix_list_routes` as defined below.
    (Required) `name` - The name of the route rule.
    (Required) `destination` - The destination Prefix List of the route rule.
    (Required) `target` - A configuration of the target of the route rule. `target` as defined below.
      (Required) `type` - The type of the target of the route rule. Valid values are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`.
      (Required) `id` - The ID of the target of the route rule.
  EOF
  type = list(object({
    name        = string
    destination = string

    target = object({
      type = string
      id   = string
    })
  }))
  default  = []
  nullable = false
}

variable "timeouts" {
  description = "(Optional) How long to wait for the route table to be created/updated/deleted."
  type = object({
    create = optional(string, "5m")
    update = optional(string, "2m")
    delete = optional(string, "5m")
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
