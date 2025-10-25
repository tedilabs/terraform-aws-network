###################################################
# IPv4 Routes
###################################################

# INFO: Not supported attributes
# - `instance_id` (Deprecated)
resource "aws_route" "ipv4" {
  for_each = {
    for route in var.ipv4_routes :
    route.destination => route
  }

  region = aws_route_table.this.region

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = each.key


  ## Targets
  carrier_gateway_id = (each.value.target.type == "CARRIER_GATEWAY"
    ? each.value.target.id
    : null
  )
  core_network_arn = (each.value.target.type == "CORE_NETWORK"
    ? each.value.target.id
    : null
  )
  egress_only_gateway_id = (each.value.target.type == "EGRESS_ONLY_INTERNET_GATEWAY"
    ? each.value.target.id
    : null
  )
  gateway_id = (contains(["INTERNET_GATEWAY", "VPN_GATEWAY"], each.value.target.type)
    ? each.value.target.id
    : null
  )
  local_gateway_id = (each.value.target.type == "LOCAL_GATEWAY"
    ? each.value.target.id
    : null
  )
  nat_gateway_id = (each.value.target.type == "NAT_GATEWAY"
    ? each.value.target.id
    : null
  )
  network_interface_id = (each.value.target.type == "NETWORK_INTERFACE"
    ? each.value.target.id
    : null
  )
  transit_gateway_id = (each.value.target.type == "TRANSIT_GATEWAY"
    ? each.value.target.id
    : null
  )
  vpc_endpoint_id = (each.value.target.type == "VPC_ENDPOINT"
    ? each.value.target.id
    : null
  )
  vpc_peering_connection_id = (each.value.target.type == "VPC_PEERING_CONNECTION"
    ? each.value.target.id
    : null
  )
}


###################################################
# IPv6 Routes
###################################################

resource "aws_route" "ipv6" {
  for_each = {
    for route in var.ipv6_routes :
    route.destination => route
  }

  region = aws_route_table.this.region

  route_table_id              = aws_route_table.this.id
  destination_ipv6_cidr_block = each.key


  ## Targets
  carrier_gateway_id = (each.value.target.type == "CARRIER_GATEWAY"
    ? each.value.target.id
    : null
  )
  core_network_arn = (each.value.target.type == "CORE_NETWORK"
    ? each.value.target.id
    : null
  )
  egress_only_gateway_id = (each.value.target.type == "EGRESS_ONLY_INTERNET_GATEWAY"
    ? each.value.target.id
    : null
  )
  gateway_id = (contains(["INTERNET_GATEWAY", "VPN_GATEWAY"], each.value.target.type)
    ? each.value.target.id
    : null
  )
  local_gateway_id = (each.value.target.type == "LOCAL_GATEWAY"
    ? each.value.target.id
    : null
  )
  nat_gateway_id = (each.value.target.type == "NAT_GATEWAY"
    ? each.value.target.id
    : null
  )
  network_interface_id = (each.value.target.type == "NETWORK_INTERFACE"
    ? each.value.target.id
    : null
  )
  transit_gateway_id = (each.value.target.type == "TRANSIT_GATEWAY"
    ? each.value.target.id
    : null
  )
  vpc_endpoint_id = (each.value.target.type == "VPC_ENDPOINT"
    ? each.value.target.id
    : null
  )
  vpc_peering_connection_id = (each.value.target.type == "VPC_PEERING_CONNECTION"
    ? each.value.target.id
    : null
  )
}


###################################################
# Prefix List Routes
###################################################

resource "aws_route" "prefix_list" {
  for_each = {
    for route in var.prefix_list_routes :
    route.name => route
  }

  region = aws_route_table.this.region

  route_table_id             = aws_route_table.this.id
  destination_prefix_list_id = each.value.destination


  ## Targets
  carrier_gateway_id = (each.value.target.type == "CARRIER_GATEWAY"
    ? each.value.target.id
    : null
  )
  core_network_arn = (each.value.target.type == "CORE_NETWORK"
    ? each.value.target.id
    : null
  )
  egress_only_gateway_id = (each.value.target.type == "EGRESS_ONLY_INTERNET_GATEWAY"
    ? each.value.target.id
    : null
  )
  gateway_id = (contains(["INTERNET_GATEWAY", "VPN_GATEWAY"], each.value.target.type)
    ? each.value.target.id
    : null
  )
  local_gateway_id = (each.value.target.type == "LOCAL_GATEWAY"
    ? each.value.target.id
    : null
  )
  nat_gateway_id = (each.value.target.type == "NAT_GATEWAY"
    ? each.value.target.id
    : null
  )
  network_interface_id = (each.value.target.type == "NETWORK_INTERFACE"
    ? each.value.target.id
    : null
  )
  transit_gateway_id = (each.value.target.type == "TRANSIT_GATEWAY"
    ? each.value.target.id
    : null
  )
  vpc_endpoint_id = (each.value.target.type == "VPC_ENDPOINT"
    ? each.value.target.id
    : null
  )
  vpc_peering_connection_id = (each.value.target.type == "VPC_PEERING_CONNECTION"
    ? each.value.target.id
    : null
  )
}
