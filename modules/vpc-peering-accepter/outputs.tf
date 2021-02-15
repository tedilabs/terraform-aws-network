output "name" {
  description = "The VPC Peering name."
  value       = var.name
}

output "id" {
  description = "The ID of the VPC Peering Connection."
  value       = aws_vpc_peering_connection_accepter.this.id
}

output "status" {
  description = "The status of the VPC Peering Connection request."
  value       = aws_vpc_peering_connection_accepter.this.accept_status
}

output "requester_id" {
  description = "The AWS account ID of the owner of the requester VPC."
  value       = aws_vpc_peering_connection_accepter.this.peer_owner_id
}

output "requester_region" {
  description = "The region of the requester VPC."
  value       = aws_vpc_peering_connection_accepter.this.peer_region
}

output "requester_vpc_id" {
  description = "The ID of the requester VPC."
  value       = aws_vpc_peering_connection_accepter.this.peer_vpc_id
}

output "accepter_id" {
  description = "The AWS account ID of the owner of the accepter VPC."
  value       = data.aws_caller_identity.this.account_id
}

output "accepter_region" {
  description = "The region of the accepter VPC."
  value       = data.aws_region.this.name
}

output "accepter_vpc_id" {
  description = "The ID of the accepter VPC."
  value       = aws_vpc_peering_connection_accepter.this.vpc_id
}
