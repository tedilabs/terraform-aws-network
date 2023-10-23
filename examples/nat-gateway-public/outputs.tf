output "elastic_ip" {
  description = "The Elastic IP."
  value       = module.elastic_ip
}

output "nat_gateway" {
  description = "The NAT Gateway."
  value       = module.nat_gateway
}
