output "vpc" {
  description = "The VPC."
  value       = module.vpc
}

output "subnet_groups" {
  description = "The Subnet Groups for the VPC."
  value = {
    private = module.private_subnet_group
    public  = module.public_subnet_group
  }
}

output "nat_gateways" {
  description = "The NAT Gateways."
  value = {
    public  = module.public_nat_gateway
    private = module.private_nat_gateway
  }
}

output "nacls" {
  description = "The Network ACLs."
  value = {
    public  = module.public_network_acl
    private = module.private_network_acl
  }
}

output "route_tables" {
  description = "The Route Tables."
  value = {
    public  = module.public_route_table
    private = module.private_route_table
  }
}

