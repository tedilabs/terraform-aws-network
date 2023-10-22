output "name" {
  description = "The name of the VPC."
  value       = var.name
}

output "owner" {
  description = "The ID of the AWS account that owns the VPC."
  value       = aws_vpc.this.owner_id
}

output "id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "arn" {
  description = "The ARN (Amazon Resource Name) of the VPC."
  value       = aws_vpc.this.arn
}

output "ipv4_cidrs" {
  description = "The list of IPv4 CIDR blocks for the VPC."
  value = concat(
    [aws_vpc.this.cidr_block],
    [
      for association in aws_vpc_ipv4_cidr_block_association.this :
      association.cidr_block
    ]
  )
}

output "ipv4_cidr_configurations" {
  description = "The list of IPv4 CIDR configurations for the VPC."
  value = merge({
    (aws_vpc.this.cidr_block) = {
      type = aws_vpc.this.ipv4_ipam_pool_id != null ? "IPAM_POOL" : "MANUAL"

      ipam_pool = (aws_vpc.this.ipv4_ipam_pool_id != null
        ? {
          id             = aws_vpc.this.ipv4_ipam_pool_id
          netmask_length = aws_vpc.this.ipv4_netmask_length
        }
        : null
      )
    },
    }, {
    for association in aws_vpc_ipv4_cidr_block_association.this :
    (association.cidr_block) => {
      type = association.ipv4_ipam_pool_id != null ? "IPAM_POOL" : "MANUAL"
      ipam_pool = (association.ipv4_ipam_pool_id != null
        ? {
          id             = association.ipv4_ipam_pool_id
          netmask_length = association.ipv4_netmask_length
        }
        : null
      )
    }
  })
}

output "ipv6_cidrs" {
  description = "The list of IPv6 CIDR blocks for the VPC."
  value = (local.ipv6_enabled
    ? concat(
      [aws_vpc.this.ipv6_cidr_block],
      [
        for association in aws_vpc_ipv6_cidr_block_association.this :
        association.ipv6_cidr_block
      ]
    )
    : []
  )
}

output "ipv6_cidr_configurations" {
  description = "The list of IPv6 CIDR configurations for the VPC."
  value = (local.ipv6_enabled
    ? merge({
      (aws_vpc.this.ipv6_cidr_block) = {
        type = length(compact([aws_vpc.this.ipv6_ipam_pool_id])) > 0 ? "IPAM_POOL" : "AMAZON"
        amazon = (length(compact([aws_vpc.this.ipv6_ipam_pool_id])) < 1
          ? {
            network_border_group = aws_vpc.this.ipv6_cidr_block_network_border_group
          }
          : null
        )
        ipam_pool = (length(compact([aws_vpc.this.ipv6_ipam_pool_id])) > 0
          ? {
            id             = aws_vpc.this.ipv6_ipam_pool_id
            netmask_length = aws_vpc.this.ipv6_netmask_length
          }
          : null
        )
      },
      }, {
      for association in aws_vpc_ipv6_cidr_block_association.this :
      (association.ipv6_cidr_block) => {
        type = length(compact([association.ipv6_ipam_pool_id])) > 0 ? "IPAM_POOL" : "AMAZON"
        amazon = (length(compact([association.ipv6_ipam_pool_id])) < 1
          ? {
            # TODO: Not supported yet
            network_border_group = null
          }
          : null
        )
        ipam_pool = (length(compact([association.ipv6_ipam_pool_id])) > 0
          ? {
            id             = association.ipv6_ipam_pool_id
            netmask_length = association.ipv6_netmask_length
          }
          : null
        )
      }
    })
    : {}
  )
}

output "tenancy" {
  description = "A tenancy option for instances launched into the VPC."
  value = {
    for k, v in local.tenancy :
    v => k
  }[aws_vpc.this.instance_tenancy]
}

output "network_address_usage_metrics_enabled" {
  description = "Whether NAU (Network Address Usage) metrics are enabled for the VPC."
  value       = aws_vpc.this.enable_network_address_usage_metrics
}

output "dns_hostnames_enabled" {
  description = "Whether instances launched in the VPC receive public DNS hostnames that correspond to their public IP addresses."
  value       = aws_vpc.this.enable_dns_hostnames
}

output "dns_resolution_enabled" {
  description = "Whether DNS resolution through the Amazon DNS server is supported for the VPC."
  value       = aws_vpc.this.enable_dns_support
}

output "dns_dnssec_validation_enabled" {
  description = "Whether or not the VPC has Route53 DNSSEC validation support."
  value       = var.dns_dnssec_validation_enabled
}

output "dns_dnssec_validation_id" {
  description = "The ID of a configuration for DNSSEC validation."
  value       = one(aws_route53_resolver_dnssec_config.this[*].id)
}

output "private_hosted_zones" {
  description = "List of associated private Hosted Zone IDs."
  value       = values(aws_route53_zone_association.this)[*].zone_id
}

output "default_network_acl" {
  description = <<EOF
  The configuration for the default Network ACL of the VPC.
    `id` - The ID of the default Network ACL.
    `arn` - The ARN of the default Network ACL.
    `owner` - The ID of the AWS account that owns the default Network ACL.
  EOF
  value = {
    id    = aws_vpc.this.default_network_acl_id
    arn   = aws_default_network_acl.this.arn
    owner = aws_default_network_acl.this.owner_id
  }
}

output "default_route_table" {
  description = <<EOF
  The configuration for the default Route Table of the VPC.
    `id` - The ID of the default Route Table.
  EOF
  value = {
    id = aws_vpc.this.default_route_table_id
  }
}

output "default_security_group" {
  description = <<EOF
  The configuration for the default Security Group of the VPC.
    `id` - The ID of the default Security Group.
    `arn` - The ARN of the default Security Group.
    `owner` - The ID of the AWS account that owns the default Security Group.
    `name` - The name of the default Security Group.
    `description` - The description of the default Security Group.
  EOF
  value = {
    id          = aws_vpc.this.default_security_group_id
    arn         = aws_default_security_group.this.arn
    owner       = aws_default_security_group.this.owner_id
    name        = aws_default_security_group.this.name
    description = aws_default_security_group.this.description
  }
}

output "main_route_table" {
  description = <<EOF
  The configuration for the main Route Table of the VPC. Note that you can change a VPC's main route table.
    `id` - The ID of the main Route Table.
  EOF
  value = {
    id = aws_vpc.this.main_route_table_id
  }
}

output "dhcp_options" {
  description = <<EOF
  The configuration for the DHCP Option Set of the VPC.
    `id` - The ID of the DHCP Options Set.
    `arn` - The ARN of the DHCP Options Set.
    `owner` - The ID of the AWS account that owns the DHCP Option Set.

    `domain_name` - The suffix domain name to use by default when resolving non Fully Qualified Domain Names.
    `domain_name_servers` - A list of name servers to configure in `/etc/resolv.conf`.
    `netbios_name_servers` - A list of NetBIOS name servers.
    `netbios_node_type` - The NetBIOS node type (1, 2, 4, or 8).
    `ntp_servers` - A list of NTP servers to configure.
  EOF
  value = (var.dhcp_options.enabled
    ? {
      id    = one(aws_vpc_dhcp_options.this[*].id)
      arn   = one(aws_vpc_dhcp_options.this[*].arn)
      owner = one(aws_vpc_dhcp_options.this[*].owner_id)

      domain_name          = one(aws_vpc_dhcp_options.this[*].domain_name)
      domain_name_servers  = one(aws_vpc_dhcp_options.this[*].domain_name_servers)
      netbios_name_servers = one(aws_vpc_dhcp_options.this[*].netbios_name_servers)
      netbios_node_type    = one(aws_vpc_dhcp_options.this[*].netbios_node_type)
      ntp_servers          = one(aws_vpc_dhcp_options.this[*].ntp_servers)
    }
    : null
  )
}

output "internet_gateway" {
  description = <<EOF
  The configuration for the Internet Gateway of the VPC.
    `id` - The ID of the Internet Gateway.
    `arn` - The ARN of the Internet Gateway.
    `owner` - The ID of the AWS account that owns the internet gateway.
  EOF
  value = (var.internet_gateway.enabled
    ? {
      id    = one(aws_internet_gateway.this[*].id)
      arn   = one(aws_internet_gateway.this[*].arn)
      owner = one(aws_internet_gateway.this[*].owner_id)
    }
    : null
  )
}

output "egress_only_internet_gateway" {
  description = <<EOF
  The configuration for the Egress-only Internet Gateway of the VPC.
    `id` - The ID of the Egress-only Internet Gateway.
  EOF
  value = (var.egress_only_internet_gateway.enabled
    ? {
      id = one(aws_egress_only_internet_gateway.this[*].id)
    }
    : null
  )
}

output "vpn_gateway" {
  description = <<EOF
  The configuration for the virtual private gateway of the VPC.
    `id` - The ID of the Virtual Private Gateway.
    `arn` - The ARN of the Virtual Private Gateway.
    `asn` - The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN.
  EOF
  value = (var.vpn_gateway.enabled
    ? {
      id  = one(aws_vpn_gateway.this[*].id)
      arn = one(aws_vpn_gateway.this[*].arn)
      asn = one(aws_vpn_gateway.this[*].amazon_side_asn)
    }
    : null
  )
}
