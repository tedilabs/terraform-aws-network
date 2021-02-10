output "name" {
  description = "The VPC name."
  value       = var.name
}

output "id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.this.arn
}

output "cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

output "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks of the VPC."
  value       = aws_vpc_ipv4_cidr_block_association.this.*.cidr_block
}

output "ipv6_cidr_block" {
  description = "The IPv6 CIDR block."
  value       = aws_vpc.this.ipv6_cidr_block
}

output "ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block."
  value       = aws_vpc.this.ipv6_association_id
}

output "instance_tenancy" {
  description = "Tenancy of instances spin up within VPC."
  value       = aws_vpc.this.instance_tenancy
}

output "dns_support_enabled" {
  description = "Whether or not the VPC has DNS support."
  value       = aws_vpc.this.enable_dns_support
}

output "dns_hostnames_enabled" {
  description = "Whether or not the VPC has DNS hostname support."
  value       = aws_vpc.this.enable_dns_hostnames
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation."
  value       = aws_vpc.this.default_security_group_id
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL."
  value       = aws_vpc.this.default_network_acl_id
}

output "default_route_table_id" {
  description = "The ID of the default route table."
  value       = aws_vpc.this.default_route_table_id
}

output "main_route_table_id" {
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table."
  value       = aws_vpc.this.main_route_table_id
}

output "dhcp_options_enabled" {
  description = "Whether DHCP options set is enabled in the VPC."
  value       = var.dhcp_options_enabled
}

output "dhcp_options_id" {
  description = "The ID of the DHCP Options Set."
  value       = element(concat(aws_vpc_dhcp_options.this.*.id, [""]), 0)
}

output "dhcp_options_arn" {
  description = "The ARN of the DHCP Options Set."
  value       = element(concat(aws_vpc_dhcp_options.this.*.arn, [""]), 0)
}

output "internet_gateway_enabled" {
  description = "Whether Internet Gateway is enabled in the VPC."
  value       = var.internet_gateway_enabled
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway."
  value       = element(concat(aws_internet_gateway.this.*.id, [""]), 0)
}

output "internet_gateway_arn" {
  description = "The ARN of the Internet Gateway."
  value       = element(concat(aws_internet_gateway.this.*.arn, [""]), 0)
}

output "egress_only_internet_gateway_enabled" {
  description = "Whether Egress Only Internet Gateway is enabled in the VPC."
  value       = var.egress_only_internet_gateway_enabled
}

output "egress_only_internet_gateway_id" {
  description = "The ID of the Egress Only Internet Gateway."
  value       = element(concat(aws_egress_only_internet_gateway.this.*.id, [""]), 0)
}

output "vpn_gateway_enabled" {
  description = "Whether VPN Gateway is enabled in the VPC."
  value       = var.vpn_gateway_enabled
}

output "vpn_gateway_id" {
  description = "The ID of the Virtual Private Gateway."
  value       = element(concat(aws_vpn_gateway.this.*.id, [""]), 0)
}

output "vpn_gateway_arn" {
  description = "The ARN of the Virtual Private Gateway."
  value       = element(concat(aws_vpn_gateway.this.*.arn, [""]), 0)
}

output "vpn_gateway_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN."
  value       = element(concat(aws_vpn_gateway.this.*.amazon_side_asn, [""]), 0)
}
