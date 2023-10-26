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

output "public_nat_gateways" {
  description = "The NAT Gateways in public."
  value       = module.public_nat_gateway
}

output "private_nat_gateways" {
  description = "The NAT Gateways in private."
  value       = module.private_nat_gateway
}
