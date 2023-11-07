variable "name" {
  description = "(Required) Desired name for the VPC resources."
  type        = string
  nullable    = false
}

variable "ipv4_cidrs" {
  description = <<EOF
  (Required) A list of IPv4 CIDR blocks for the VPC. At least one CIDR must be defined. Each block of `ipv4_cidrs` as defined below.
    (Optional) `type` - Valid values are `MANUAL` and `IPAM_POOL`. Defaults to `MANUAL`.
    (Optional) `cidr` - The CIDR block for the VPC. CIDR block size must be between /16 and /28.
    (Optional) `ipam_pool` - The configuration to get an IPv4 CIDR from the IPAM pool to use for the VPC. Required if `type` is `IPAM_POOL`. `ipam_pool` as defined below.
      (Required) `id` - The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR.
      (Optional) `netmask_length` - The netmask length of the IPv4 CIDR you want to allocate to this VPC.
  EOF
  type = list(object({
    type = optional(string, "MANUAL")
    cidr = optional(string)
    ipam_pool = optional(object({
      id             = string
      netmask_length = optional(number)
    }))
  }))
  default  = []
  nullable = false

  validation {
    condition     = length(var.ipv4_cidrs) > 0
    error_message = "At least one IPv4 CIDR must be defined."
  }
  validation {
    condition = alltrue([
      for ipv4_cidr in var.ipv4_cidrs :
      contains(["MANUAL", "IPAM_POOL"], ipv4_cidr.type)
    ])
    error_message = "Valid values for `type` of each IPv4 CIDR are `MANUAL` and `IPAM_POOL`."
  }
}

variable "ipv6_cidrs" {
  description = <<EOF
  (Optional) A list of IPv6 CIDR blocks for the VPC. Each block of `ipv6_cidrs` as defined below.
    (Optional) `type` - Valid values are `AMAZON` and `IPAM_POOL`. Defaults to `AMAZON`.
    (Optional) `amazon` - The configuration to get the Amazon-provided IPv6 CIDR to use for the VPC. Only used if `type` is `AMAZON`. `amazon` as defined below.
      (Optional) `network_border_group` - The name of the network border group. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones. Defaults to the region of the VPC.
    (Optional) `ipam_pool` - The configuration to get an IPv6 CIDR from the IPAM pool to use for the VPC. Required if `type` is `IPAM_POOL`. `ipam_pool` as defined below.
      (Required) `id` - The ID of an IPv6 IPAM pool you want to use for allocating this VPC's CIDR.
      (Optional) `cidr` - The CIDR block for the VPC. The CIDR can be explicitly set. Required if `netmask_length` is not set and the IPAM pool does not have `allocation_default_netmask` set.
      (Optional) `netmask_length` - The netmask length of the IPv6 CIDR you want to allocate to this VPC.
  EOF
  type = list(object({
    type = optional(string, "AMAZON")
    amazon = optional(object({
      network_border_group = optional(string)
    }), {})
    ipam_pool = optional(object({
      id             = string
      cidr           = optional(string)
      netmask_length = optional(number)
    }))
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for ipv6_cidr in var.ipv6_cidrs :
      contains(["AMAZON", "IPAM_POOL"], ipv6_cidr.type)
    ])
    error_message = "Valid values for `type` of each IPv6 CIDR are `AMAZON` and `IPAM_POOL`."
  }
}

variable "tenancy" {
  description = <<EOF
  (Optional) A tenancy option for instances launched into the VPC. Valid values are `DEFAULT` and `DEDICATED`. Defaults to `DEFAULT`.
    `DEFAULT` - Ensure that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched
    `DEDICATED` - Ensure that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee.
  EOF
  type        = string
  default     = "DEFAULT"
  nullable    = false

  validation {
    condition     = contains(["DEFAULT", "DEDICATED"], var.tenancy)
    error_message = "Valid values for `tenancy` are `DEFAULT` and `DEDICATED`."
  }
}

variable "network_address_usage_metrics_enabled" {
  description = "(Optional) Whether NAU (Network Address Usage) metrics are enabled for the VPC. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "dns_hostnames_enabled" {
  description = "(Optional) Whether instances launched in the VPC receive public DNS hostnames that correspond to their public IP addresses. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "dns_resolution_enabled" {
  description = "(Optional) Whether DNS resolution through the Amazon DNS server is supported for the VPC. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "dns_dnssec_validation_enabled" {
  description = "(Optional) Should be true to enable Route53 DNSSEC validation in the VPC."
  type        = bool
  default     = false
  nullable    = false
}

variable "private_hosted_zones" {
  description = "(Optional) List of private Hosted Zone IDs to associate."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "default_network_acl" {
  description = <<EOF
  (Optional) The configuration for the default Network ACL of the VPC. `default_network_acl` as defined below.
    (Optional) `name` - The name of the default Network ACL. Defaults to same name of the VPC.
    (Optional) `ingress_rules` - A set of ingress rules in the default Network ACL. If not explicitly defined, the AWS default rules are applied. `ingress_rules` as defined below.
      (Required) `priority` - The rule priority. The rule number. Used for ordering.
      (Required) `action` - The action to indicate whether to allow or deny the traffic that matches the rule. Valid values are `ALLOW` and `DENY`.
      (Required) `protocol` - The protocol to match. If using the `-1` 'all' protocol, you must specify a from and to port of `0`.
      (Required) `from_port` - The from port to match.
      (Required) `to_port` - The to port to match.
      (Optional) `ipv4_cidr` - The IPv4 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv6_cidr`.
      (Optional) `ipv6_cidr` - The IPv6 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv4_cidr`.
      (Optional) `icmp_type` - The ICMP type to be used. Defaults to `0`.
      (Optional) `icmp_code` - The ICMP code to be used. Defaults to `0`.
    (Optional) `egress_rules` - A set of egress rules in the default Network ACL. If not explicitly defined, the AWS default rules are applied. `egress_rules` as defined below.
      (Required) `priority` - The rule priority. The rule number. Used for ordering.
      (Required) `action` - The action to indicate whether to allow or deny the traffic that matches the rule. Valid values are `ALLOW` and `DENY`.
      (Required) `protocol` - The protocol to match. If using the `-1` 'all' protocol, you must specify a from and to port of `0`.
      (Required) `from_port` - The from port to match.
      (Required) `to_port` - The to port to match.
      (Optional) `ipv4_cidr` - The IPv4 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv6_cidr`.
      (Optional) `ipv6_cidr` - The IPv6 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv4_cidr`.
      (Optional) `icmp_type` - The ICMP type to be used. Defaults to `0`.
      (Optional) `icmp_code` - The ICMP code to be used. Defaults to `0`.
  EOF
  type = object({
    name = optional(string)
    ingress_rules = optional(set(object({
      priority  = number
      action    = string
      protocol  = string
      from_port = number
      to_port   = number
      ipv4_cidr = optional(string)
      ipv6_cidr = optional(string)
      icmp_type = optional(number, 0)
      icmp_code = optional(number, 0)
    })))
    egress_rules = optional(set(object({
      priority  = number
      action    = string
      protocol  = string
      from_port = number
      to_port   = number
      ipv4_cidr = optional(string)
      ipv6_cidr = optional(string)
      icmp_type = optional(number, 0)
      icmp_code = optional(number, 0)
    })))
  })
  default  = {}
  nullable = false

  validation {
    condition = (var.default_network_acl.ingress_rules != null
      ? alltrue([
        for rule in var.default_network_acl.ingress_rules :
        contains(["ALLOW", "DENY"], rule.action)
      ])
      : true
    )
    error_message = "Valid values for `action` of each rules are `ALLOW` and `DENY`."
  }
  validation {
    condition = (var.default_network_acl.egress_rules != null
      ? alltrue([
        for rule in var.default_network_acl.egress_rules :
        contains(["ALLOW", "DENY"], rule.action)
      ])
      : true
    )
    error_message = "Valid values for `action` of each rules are `ALLOW` and `DENY`."
  }
}

variable "default_security_group" {
  description = <<EOF
  (Optional) The configuration for the default Security Group of the VPC. `default_security_group` as defined below.
    (Optional) `name` - The name of the default Security Group. Defaults to same name of the VPC.
    (Optional) `ingress_rules` - A set of ingress rules in the default Security Group. If not explicitly defined, the AWS default rules are applied. `ingress_rules` as defined below.
      (Optional) `description` - The description of the rule.
      (Required) `protocol` - The protocol to match. If using the `-1` 'all' protocol, you must specify a from and to port of `0`.
      (Required) `from_port` - The from port to match.
      (Required) `to_port` - The to port to match.
      (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation. Cannot be specified with `ipv6_cidrs`.
      (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation. Cannot be specified with `ipv4_cidrs`.
      (Optional) `prefix_lists` - The prefix list IDs to allow.
      (Optional) `security_groups` - The source security group IDs to allow.
      (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule.
    (Optional) `egress_rules` - A set of egress rules in the default Security Group. If not explicitly defined, the AWS default rules are applied. `egress_rules` as defined below.
      (Optional) `description` - The description of the rule.
      (Required) `protocol` - The protocol to match. If using the `-1` 'all' protocol, you must specify a from and to port of `0`.
      (Required) `from_port` - The from port to match.
      (Required) `to_port` - The to port to match.
      (Optional) `ipv4_cidrs` - The IPv4 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv6_cidrs`.
      (Optional) `ipv6_cidrs` - The IPv6 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv4_cidrs`.
      (Optional) `prefix_lists` - The prefix list IDs to allow.
      (Optional) `security_groups` - The source security group IDs to allow.
      (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule.
  EOF
  type = object({
    name = optional(string)
    ingress_rules = optional(set(object({
      description     = optional(string, "Managed by Terraform.")
      protocol        = string
      from_port       = number
      to_port         = number
      ipv4_cidrs      = optional(set(string))
      ipv6_cidrs      = optional(set(string))
      prefix_lists    = optional(set(string))
      security_groups = optional(set(string))
      self            = optional(bool, false)
    })))
    egress_rules = optional(set(object({
      description     = optional(string, "Managed by Terraform.")
      protocol        = string
      from_port       = number
      to_port         = number
      ipv4_cidrs      = optional(set(string))
      ipv6_cidrs      = optional(set(string))
      prefix_lists    = optional(set(string))
      security_groups = optional(set(string))
      self            = optional(bool, false)
    })))
  })
  default  = {}
  nullable = false
}

variable "dhcp_options" {
  description = <<EOF
  (Optional) The configuration for a DHCP option set of the VPC. Dynamic Host Configuration Protocol (DHCP) provides a standard for passing configuration information to hosts on a TCP/IP network. `dhcp_options` as defined below.
    (Optional) `enabled` - Whether to create a DHCP option set for the VPC. Defaults to `false`.
    (Optional) `name` - The name of the DHCP option set. Defaults to same name of the VPC.
    (Optional) `domain_name` - The suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the `/etc/resolv.conf` file. If you're using `AmazonProvidedDNS` in `us-east-1`, specify `ec2.internal`. If you're using `AmazonProvidedDNS` in another Region, specify `{region}.compute.internal`.
    (Optional) `domain_name_servers` - A list of name servers to configure in `/etc/resolv.conf`. The IP addresses of up to four domain name servers, or `AmazonProvidedDNS`. If you want to use the default AWS nameservers you should set this to `AmazonProvidedDNS`. Defaults to `["AmazonProvidedDNS"]`.
    (Optional) `netbios_name_servers` - A list of NetBIOS name servers. The IP addresses of up to four NetBIOS name servers.
    (Optional) `netbios_node_type` - The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132. Defaults to `2`.
    (Optional) `ntp_servers` - A list of NTP servers to configure. The IP addresses of up to four Network Time Protocol (NTP) servers.
  EOF
  type = object({
    enabled              = optional(bool, false)
    name                 = optional(string)
    domain_name          = optional(string)
    domain_name_servers  = optional(list(string), ["AmazonProvidedDNS"])
    netbios_name_servers = optional(list(string), [])
    netbios_node_type    = optional(number, 2)
    ntp_servers          = optional(list(string), [])
  })
  default  = {}
  nullable = false
}

variable "internet_gateway" {
  description = <<EOF
  (Required) The configuration for an Internet Gateway of the VPC. An internet gateway is a virtual router that connects a VPC to the internet. `internet_gateway` as defined below.
    (Optional) `enabled` - Whether to create an Internet gateway for the VPC. Defaults to `true`.
    (Optional) `name` - The name of the Internet Gateway. Defaults to same name of the VPC.
  EOF
  type = object({
    enabled = optional(bool, true)
    name    = optional(string)
  })
  default  = {}
  nullable = false
}

variable "egress_only_internet_gateway" {
  description = <<EOF
  (Required) The configuration for an Egress-only Internet Gateway of the VPC. Egress-only Internet Gateway is VPC component that allows outbound only communication to the internet over IPv6, and prevents the Internet from initiating an IPv6 connection with your instances. `egress_only_internet_gateway` as defined below.
    (Optional) `enabled` - Whether to create an egress-only Internet gateway for the VPC. Defaults to `false`.
    (Optional) `name` - The name of the Egress-only Internet Gateway. Defaults to same name of the VPC.
  EOF
  type = object({
    enabled = optional(bool, false)
    name    = optional(string)
  })
  default  = {}
  nullable = false
}

variable "vpn_gateway" {
  description = <<EOF
  (Required) The configuration for a virtual private gateway of the VPC. A virtual private gateway is the VPN concentrator on the Amazon side of the site-to-site VPN connection. `vpn_gateway` as defined below.
    (Optional) `enabled` - Whether to create a new VPN Gateway resource and attach it to the VPC. Defaults to `false`.
    (Optional) `name` - The name of the VPN Gateway. Defaults to same name of the VPC.
    (Optional) `asn` - The Autonomous System Number (ASN) for the Amazon side of the gateway. Defaults to `64512`.
  EOF
  type = object({
    enabled = optional(bool, false)
    name    = optional(string)
    asn     = optional(number, 64512)
  })
  default  = {}
  nullable = false

  validation {
    condition = anytrue([
      var.vpn_gateway.asn >= 64512 && var.vpn_gateway.asn <= 65534,
      var.vpn_gateway.asn >= 4200000000 && var.vpn_gateway.asn <= 4294967294,
    ])
    error_message = "Value of `asn` must be in the `64512` - `65534` or `4200000000` - `4294967294` range."
  }
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
