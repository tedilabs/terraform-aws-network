output "id" {
  description = "The ID of the virtual interface."
  value       = aws_dx_private_virtual_interface.this.id
}

output "arn" {
  description = "The ARN of the virtual interface."
  value       = aws_dx_private_virtual_interface.this.arn
}

output "name" {
  description = "The name of the virtual interface."
  value       = aws_dx_private_virtual_interface.this.name
}

output "connection" {
  description = "The ID of the Direct Connect connection."
  value       = aws_dx_private_virtual_interface.this.connection_id
}

output "gateway" {
  description = "The ID of the Direct Connect connection."
  value = {
    type = var.gateway.type
    id = {
      "DIRECT_CONNECT_GATEWAY"  = aws_dx_private_virtual_interface.this.dx_gateway_id
      "VIRTUAL_PRIVATE_GATEWAY" = aws_dx_private_virtual_interface.this.vpn_gateway_id
    }[var.gateway.type]
  }
}

output "vlan" {
  description = "The ID of the VLAN."
  value       = aws_dx_private_virtual_interface.this.vlan
}

output "aws_device" {
  description = "The Direct Connect endpoint on which the virtual interface terminates."
  value       = aws_dx_private_virtual_interface.this.aws_device
}

output "jumbo_frame_capable" {
  description = "Whether jumbo frames (9001 MTU) are supported."
  value       = aws_dx_private_virtual_interface.this.jumbo_frame_capable
}

output "jumbo_frame_enabled" {
  description = "Whether jumbo frames (9001 MTU) are enabled."
  value       = aws_dx_private_virtual_interface.this.mtu == 9001
}

output "mtu" {
  description = "The MTU of the virtual interface."
  value       = aws_dx_private_virtual_interface.this.mtu
}

output "sitelink_enabled" {
  description = "Indicate whether to enable SiteLink."
  value       = aws_dx_private_virtual_interface.this.sitelink_enabled
}

output "bgp_peerings" {
  description = <<EOF
  The configuration for BGP(Border Gateway Protocol) Peerings of the virtual interface.
    `address_family` - The address family for the BGP peer.
    `bgp_asn` - The Border Gateway Protocol (BGP) Autonomous System Number (ASN) of your on-premises router.
    `bgp_auth_key` - The password that will be used to authenticate the BGP session.
    `amazon_address` - The BGP peer IP configured on the AWS endpoint.
    `customer_address` - The BGP peer IP configured on your endpoint.
  EOF
  value = concat(
    [{
      address_family = {
        for k, v in local.address_family :
        v => k
      }[aws_dx_private_virtual_interface.this.address_family]
      bgp_asn          = aws_dx_private_virtual_interface.this.bgp_asn
      bgp_auth_key     = aws_dx_private_virtual_interface.this.bgp_auth_key
      amazon_address   = aws_dx_private_virtual_interface.this.amazon_address
      customer_address = aws_dx_private_virtual_interface.this.customer_address
    }],
    [
      for peering in aws_dx_bgp_peer.this : {
        address_family = {
          for k, v in local.address_family :
          v => k
        }[peering.address_family]
        bgp_asn          = peering.bgp_asn
        bgp_auth_key     = peering.bgp_auth_key
        amazon_address   = peering.amazon_address
        customer_address = peering.customer_address
      }
    ]
  )
}

output "sample_configuration" {
  description = "The sample router configuration for the virtual interface."
  value = {
    router = one([
      for router in local.routers :
      router
      if router.id == var.router
    ])
    config = one(data.aws_dx_router_configuration.this[*].customer_router_config)
  }
}
