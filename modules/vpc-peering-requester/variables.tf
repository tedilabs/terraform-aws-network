variable "name" {
  description = "Desired name for the VPC Peering resources."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
  default     = ""
}

variable "accepter_id" {
  description = "The AWS account ID of the owner of the peer VPC."
  type        = string
  default     = ""
}

variable "accepter_region" {
  description = "The region of the VPC with which you are creating the VPC Peering Connection."
  type        = string
  default     = ""
}

variable "accepter_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection."
  type        = string
  default     = ""
}

variable "allow_remote_vpc_dns_resolution" {
  description = "Allow a requester VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the accepter VPC. This is not supported for inter-region VPC peering."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
