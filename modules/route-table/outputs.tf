output "region" {
  description = "The AWS region this module resources resides in."
  value       = aws_route_table.this.region
}

output "vpc_id" {
  description = "The ID of the VPC which the route table belongs to."
  value       = var.vpc_id
}

output "id" {
  description = "The ID of the routing table."
  value       = aws_route_table.this.id
}

output "arn" {
  description = "The ARN of the routing table."
  value       = aws_route_table.this.arn
}

output "owner_id" {
  description = "The ID of the AWS account that owns subnets in the routing table."
  value       = aws_route_table.this.owner_id
}

output "name" {
  description = "The name of the routing table."
  value       = var.name
}

output "is_main" {
  description = "Whether to set this route table as the main route table."
  value       = var.is_main
}

output "ipv4_routes" {
  description = "A list of route rules for destinations to IPv4 CIDRs."
  value = [
    for route in var.ipv4_routes : {
      id          = aws_route.ipv4[route.destination].id,
      state       = aws_route.ipv4[route.destination].state,
      origin      = aws_route.ipv4[route.destination].origin,
      destination = route.destination
      target = {
        type = route.target.type
        id = coalesce(
          aws_route.ipv4[route.destination].carrier_gateway_id,
          aws_route.ipv4[route.destination].core_network_arn,
          aws_route.ipv4[route.destination].egress_only_gateway_id,
          aws_route.ipv4[route.destination].gateway_id,
          aws_route.ipv4[route.destination].local_gateway_id,
          aws_route.ipv4[route.destination].nat_gateway_id,
          aws_route.ipv4[route.destination].network_interface_id,
          aws_route.ipv4[route.destination].transit_gateway_id,
          aws_route.ipv4[route.destination].vpc_endpoint_id,
          aws_route.ipv4[route.destination].vpc_peering_connection_id,
        )
      }
    }
  ]
}

output "ipv6_routes" {
  description = "A list of route rules for destinations to IPv6 CIDRs."
  value = [
    for route in var.ipv6_routes : {
      id          = aws_route.ipv6[route.destination].id,
      state       = aws_route.ipv6[route.destination].state,
      origin      = aws_route.ipv6[route.destination].origin,
      destination = route.destination
      target = {
        type = route.target.type
        id = coalesce(
          aws_route.ipv6[route.destination].carrier_gateway_id,
          aws_route.ipv6[route.destination].core_network_arn,
          aws_route.ipv6[route.destination].egress_only_gateway_id,
          aws_route.ipv6[route.destination].gateway_id,
          aws_route.ipv6[route.destination].local_gateway_id,
          aws_route.ipv6[route.destination].nat_gateway_id,
          aws_route.ipv6[route.destination].network_interface_id,
          aws_route.ipv6[route.destination].transit_gateway_id,
          aws_route.ipv6[route.destination].vpc_endpoint_id,
          aws_route.ipv6[route.destination].vpc_peering_connection_id,
        )
      }
    }
  ]
}

output "prefix_list_routes" {
  description = "A list of route rules for destinations to Prefix Lists."
  value = [
    for route in var.prefix_list_routes : {
      id          = aws_route.prefix_list[route.name].id,
      state       = aws_route.prefix_list[route.name].state,
      origin      = aws_route.prefix_list[route.destination].origin,
      destination = route.destination
      target = {
        type = route.target.type
        id = coalesce(
          aws_route.prefix_list[route.name].carrier_gateway_id,
          aws_route.prefix_list[route.name].core_network_arn,
          aws_route.prefix_list[route.name].egress_only_gateway_id,
          aws_route.prefix_list[route.name].gateway_id,
          aws_route.prefix_list[route.name].local_gateway_id,
          aws_route.prefix_list[route.name].nat_gateway_id,
          aws_route.prefix_list[route.name].network_interface_id,
          aws_route.prefix_list[route.name].transit_gateway_id,
          aws_route.prefix_list[route.name].vpc_endpoint_id,
          aws_route.prefix_list[route.name].vpc_peering_connection_id,
        )
      }
    }
  ]
}

output "associated_subnets" {
  description = "A list of subnet IDs which is associated with the route table."
  value       = aws_route_table_association.subnets[*].subnet_id
}

output "associated_gateways" {
  description = "A list of gateway IDs which is associated with the route table."
  value       = aws_route_table_association.gateways[*].gateway_id
}

output "associated_vpc_gateway_endpoints" {
  description = "A list of the VPC Gateway Endpoint IDs which is associated with the route table."
  value       = var.vpc_gateway_endpoints
}

output "propagated_vpn_gateways" {
  description = "A list of Virtual Private Gateway IDs which propagate routes from."
  value       = values(aws_vpn_gateway_route_propagation.this)[*].vpn_gateway_id
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
