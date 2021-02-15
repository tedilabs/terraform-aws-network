variable "name" {
  description = "Desired name for the route table resources."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC which the route table belongs to."
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the route table."
  type        = list(string)
  default     = []
}

variable "gateways" {
  description = "A list of gateway IDs to associate with the route table. Only support Internet Gateway and Virtual Private Gateway."
  type        = list(string)
  default     = []
}

variable "propagating_vpn_gateways" {
  description = "A list of Virtual Private Gateway IDs to propagate routes from."
  type        = list(string)
  default     = []
}

variable "ipv4_routes" {
  description = "A list of IPv4 route rules."
  type        = list(map(string))
  default     = []
}

variable "ipv6_routes" {
  description = "A list of IPv6 route rules."
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
