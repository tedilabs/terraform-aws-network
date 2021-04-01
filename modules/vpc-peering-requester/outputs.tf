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
  value = merge(local.requester, {
    cidr_block = data.aws_vpc_peering_connection.this.cidr_block
    secondary_cidr_blocks = [
      for cidr in data.aws_vpc_peering_connection.this.cidr_block_set :
      cidr.cidr_block
      if cidr.cidr_block != data.aws_vpc_peering_connection.this.cidr_block
    ]
  })
}

output "accepter" {
  description = "The accepter information including AWS Account ID, Region, VPC ID."
  value = merge(local.accepter, {
    cidr_block = data.aws_vpc_peering_connection.this.peer_cidr_block
    secondary_cidr_blocks = [
      for cidr in data.aws_vpc_peering_connection.this.peer_cidr_block_set :
      cidr.cidr_block
      if cidr.cidr_block != data.aws_vpc_peering_connection.this.peer_cidr_block
    ]
  })
}
