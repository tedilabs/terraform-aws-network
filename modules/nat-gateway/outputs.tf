output "id" {
  description = "The ID of the NAT Gateway."
  value       = aws_nat_gateway.this.id
}

output "name" {
  description = "The name of the NAT Gateway."
  value       = var.name
}

output "is_private" {
  description = "Whether the NAT Gateway supports public or private connectivity."
  value       = aws_nat_gateway.this.connectivity_type == "private"
}

output "availability_zone" {
  description = <<EOF
  The availability zone of the NAT Gateway.
    `id` - The ID of the availability zone.
    `name` - The name of the availability zone.
  EOF
  value = {
    id   = data.aws_subnet.this.availability_zone_id
    name = data.aws_subnet.this.availability_zone
  }
}

output "vpc_id" {
  description = "The VPC ID of the NAT Gateway."
  value       = data.aws_subnet.this.vpc_id
}

output "subnet" {
  description = <<EOF
  The subnet which the NAT Gateway belongs to.
    `id` - The ID of the subnet.
    `arn` - The ARN of the subnet.
  EOF
  value = {
    id  = aws_nat_gateway.this.subnet_id
    arn = data.aws_subnet.this.arn
  }
}

output "elastic_ip" {
  description = "The Allocation ID of the Elastic IP address for the gateway."
  value       = aws_nat_gateway.this.allocation_id
}

output "netework_interface" {
  description = "The ENI ID of the network interface created by the NAT gateway."
  value       = aws_nat_gateway.this.network_interface_id
}

output "primary_public_ip" {
  description = "The public IP address of the NAT Gateway."
  value       = aws_nat_gateway.this.public_ip
}

output "primary_private_ip" {
  description = "The private IP address of the NAT Gateway."
  value       = aws_nat_gateway.this.private_ip
}

output "secondary_private_ips" {
  description = "The secondary private IP addresses of the NAT Gateway."
  value       = aws_nat_gateway.this.secondary_private_ip_addresses
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
