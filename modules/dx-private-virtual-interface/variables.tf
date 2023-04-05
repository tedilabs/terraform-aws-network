variable "name" {
  description = "(Required) The name of the virtual interface assigned by the customer network. The name has a maximum of 100 characters. The following are valid characters: a-z, 0-9 and a hyphen (-)."
  type        = string
  nullable    = false
}

variable "connection" {
  description = "(Required) The ID of the Direct Connect connection (or LAG) on which the new virtual interface will be provisioned."
  type        = string
  nullable    = false
}

variable "gateway" {
  description = <<EOF
  (Required) The gateway configuration to connect to VPCs and Regions for this virtual interface. `gateway` as defined below.
    (Required) `type` - A gateway type for this virtual interface.
      - `DIRECT_CONNECT_GATEWAY`: Allow connections to multiple VPCs and Regions.
      - `VIRTUAL_PRIVATE_GATEWAY`: Allow connections to a single VPC in the same Region.
    (Required) `id` - The ID of the Direct Connect Gateway or Virtual Private Gateway to which to connect the virtual interface.
  EOF
  type = object({
    type = string
    id   = string
  })
  nullable = false

  validation {
    condition     = contains(["DIRECT_CONNECT_GATEWAY", "VIRTUAL_PRIVATE_GATEWAY"], var.gateway.type)
    error_message = "Valid values for `gateway.type` are `DIRECT_CONNECT_GATEWAY` and `VIRTUAL_PRIVATE_GATEWAY`."
  }
}

variable "vlan" {
  description = "(Required) The Virtual Local Area Network number for the new virtual interface. Valid ranges are 1 - 4094."
  type        = number
  nullable    = false

  validation {
    condition = alltrue([
      var.vlan >= 1,
      var.vlan <= 4094,
    ])
    error_message = "Valid ranges are 1 - 4094."
  }
}

variable "jumbo_frame_enabled" {
  description = "(Optional) Whether to allow MTU size of `9001` on virtual interface. The MTU of a virtual private interface can be either `1500` or `9001` (jumbo frames). Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "sitelink_enabled" {
  description = "(Optional) Indicate whether to enable SiteLink. Control direct connectivity between Direct Connect points of presence. Subject to additional charges. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "bgp_peerings" {
  description = <<EOF
  (Required) The configuration for BGP(Border Gateway Protocol) Peerings of the virtual interface. You must create a BGP peer for the corresponding address family (IPv4/IPv6) in order to access AWS resources that also use that address family. If logical redundancy is not supported by the connection, interconnect, or LAG, the BGP peer cannot be in the same address family as an existing BGP peer on the virtual interface. When creating a IPv6 BGP peer, omit the Amazon address and customer address. IPv6 addresses are automatically assigned from the Amazon pool of IPv6 addresses; you cannot specify custom IPv6 addresses. Each block of `bgp_peerings` as defined below.
    (Required) `address_family` - The address family for the BGP peer. Valid values are `IPV4` or `IPV6`. Defaults to `IPV4`.
    (Required) `bgp_asn` - The Border Gateway Protocol (BGP) Autonomous System Number (ASN) of your on-premises router for the new virtual interface. Valid ranges are 1 - 2147483647.
    (Optional) `bgp_auth_key` - The password that will be used to authenticate the BGP session.
    (Optional) `amazon_address` - The BGP peer IP configured on the AWS endpoint. Required for IPv4 BGP peering.
    (Optional) `customer_address` - The BGP peer IP configured on your endpoint. Required for IPv4 BGP peering.
  EOF
  type = list(object({
    address_family   = string
    bgp_asn          = number
    bgp_auth_key     = optional(string)
    amazon_address   = optional(string)
    customer_address = optional(string)
  }))
  nullable = false

  validation {
    condition     = length(var.bgp_peerings) > 0
    error_message = "At least 1 BGP peering is required."
  }
  validation {
    condition = alltrue([
      for peering in var.bgp_peerings :
      contains(["IPV4", "IPV6"], peering.address_family)
    ])
    error_message = "Valid values for `address_family` are `IPV4` and `IPV6`."
  }
  validation {
    condition = alltrue([
      for peering in var.bgp_peerings :
      alltrue([
        peering.bgp_asn >= 1,
        peering.bgp_asn <= 2147483647,
      ])
    ])
    error_message = "Valid ranges for `bgp_asn` are 1 - 2147483647."
  }
}

variable "router_configuration" {
  description = <<EOF
  (Optional) The configuration to retrieve a sample router configuration for the virtual interface. `router_configuration` as defined below.
    (Optional) `router` - The ID of the Router Type to get the sample router configuration. For example: `CiscoSystemsInc-2900SeriesRouters-IOS124`.
    (Optional) `output_path` - The path to save sample router configuration.
  EOF
  type = object({
    router      = optional(string)
    output_path = optional(string)
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
