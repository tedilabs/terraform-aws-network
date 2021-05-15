variable "name" {
  description = "Desired name for the VPC resources."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden."
  type        = string
  default     = "0.0.0.0/0"
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool."
  type        = list(string)
  default     = []
}

variable "ipv6_enabled" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
  default     = false
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC. Only support `default` or `dedicated`."
  type        = string
  default     = "default"
}

variable "dns_hostnames_enabled" {
  description = "Should be true to enable DNS hostnames in the VPC."
  type        = bool
  default     = false
}

variable "dns_support_enabled" {
  description = "Should be true to enable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "dns_dnssec_validation_enabled" {
  description = "Should be true to enable Route53 DNSSEC validation in the VPC."
  type        = bool
  default     = false
}

variable "private_hosted_zones" {
  description = "List of private Hosted Zone IDs to associate."
  type        = list(string)
  default     = []
}

variable "dhcp_options_enabled" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type."
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)."
  type        = string
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true)."
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set (requires enable_dhcp_options set to true)."
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "Specify a list of netbios servers for DHCP options set (requires enable_dhcp_options set to true)."
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "Specify netbios node_type for DHCP options set (requires enable_dhcp_options set to true)."
  type        = string
  default     = ""
}

variable "internet_gateway_enabled" {
  description = "Should be true if you want to create a new Internet Gateway resource and attach it to the VPC."
  type        = bool
  default     = true
}

variable "egress_only_internet_gateway_enabled" {
  description = "Should be true if you want to create a new Egress Only Internet Gateway resource and attach it to the VPC."
  type        = bool
  default     = false
}

variable "vpn_gateway_enabled" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC."
  type        = bool
  default     = false
}

variable "vpn_gateway_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN."
  default     = "64512"
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
