variable "id" {
  description = "The VPC Peering Connection ID to manage."
  type        = string
}

variable "name" {
  description = "Desired name for the VPC Peering resources."
  type        = string
  default     = ""
}

variable "allow_remote_vpc_dns_resolution" {
  description = "Allow a accepter VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requester VPC. This is not supported for inter-region VPC peering."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
