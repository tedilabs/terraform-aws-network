data "aws_region" "this" {
  region = var.region
}

locals {
  region = data.aws_region.this.region

  default_dhcp_options_domain_name = (local.region != "us-east-1"
    ? "${local.region}.compute.internal"
    : "ec2.internal"
  )
}


###################################################
# DHCP Options
###################################################

resource "aws_vpc_dhcp_options" "this" {
  count = var.dhcp_options.enabled ? 1 : 0

  region = var.region

  domain_name = (length(compact([var.dhcp_options.domain_name])) > 0
    ? var.dhcp_options.domain_name
    : local.default_dhcp_options_domain_name
  )
  domain_name_servers               = var.dhcp_options.domain_name_servers
  ipv6_address_preferred_lease_time = var.dhcp_options.ipv6_address_preferred_lease_time
  ntp_servers                       = var.dhcp_options.ntp_servers
  netbios_name_servers              = var.dhcp_options.netbios_name_servers
  netbios_node_type                 = var.dhcp_options.netbios_node_type

  tags = merge(
    {
      "Name" = coalesce(var.dhcp_options.name, local.metadata.name)
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.dhcp_options.enabled ? 1 : 0

  region = aws_vpc.this.region

  vpc_id          = aws_vpc.this.id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}
