output "nat_gateway" {
  description = "The NAT Gateways."
  value = {
    count       = module.nat_gateway
    assignments = module.nat_gateway_2
  }
}
