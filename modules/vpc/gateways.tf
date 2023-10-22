###################################################
# Internet Gateway
###################################################

# INFO: Not supported attributes
# - `vpc_id`
resource "aws_internet_gateway" "this" {
  count = var.internet_gateway.enabled ? 1 : 0

  tags = merge(
    {
      "Name" = coalesce(var.internet_gateway.name, local.metadata.name)
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_internet_gateway_attachment" "this" {
  count = var.internet_gateway.enabled ? 1 : 0

  vpc_id              = aws_vpc.this.id
  internet_gateway_id = aws_internet_gateway.this[0].id
}


###################################################
# Egress Only Internet Gateway (IPv6)
###################################################

resource "aws_egress_only_internet_gateway" "this" {
  count = var.egress_only_internet_gateway.enabled ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = coalesce(var.egress_only_internet_gateway.name, local.metadata.name)
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    precondition {
      condition     = local.ipv6_enabled
      error_message = "Egress Only Internet Gateway (IPv6) cannot be enabled if IPv6 is not enabled."
    }
  }
}


###################################################
# Virtual Private Gateway
###################################################

# INFO: Not supported attributes
# - `vpc_id`
# - `availability_zone`
resource "aws_vpn_gateway" "this" {
  count = var.vpn_gateway.enabled ? 1 : 0

  amazon_side_asn = var.vpn_gateway.asn

  tags = merge(
    {
      "Name" = coalesce(var.vpn_gateway.name, local.metadata.name)
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_vpn_gateway_attachment" "this" {
  count = var.vpn_gateway.enabled ? 1 : 0

  vpc_id         = aws_vpc.this.id
  vpn_gateway_id = aws_vpn_gateway.this[0].id
}
