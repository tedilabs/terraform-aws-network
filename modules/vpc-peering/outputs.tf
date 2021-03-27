output "name" {
  description = "The VPC Peering name."
  value       = var.name
}

output "id" {
  description = "The ID of the VPC Peering Connection."
  value       = aws_vpc_peering_connection.this.id
}

output "status" {
  description = "The status of the VPC Peering Connection request."
  value       = aws_vpc_peering_connection.this.accept_status
}

output "requester" {
  description = "The requester information including AWS Account ID, Region, VPC ID."
  value       = local.requester
}

output "accepter" {
  description = "The accepter information including AWS Account ID, Region, VPC ID."
  value       = local.accepter
}
