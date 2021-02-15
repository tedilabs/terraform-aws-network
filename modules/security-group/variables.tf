variable "name" {
  description = "The name of the security group. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with `name`."
  type        = string
  default     = null
}

variable "description" {
  description = "The security group description. This field maps to the AWS `GroupDescription` attribute, for which there is no Update API."
  type        = string
  default     = "Managed by Terraform."
}

variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed."
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The ID of the associated VPC."
  type        = string
}

variable "ingress_rules" {
  description = "A list of ingress rules in a security group."
  type        = any
  default     = []
}

variable "egress_rules" {
  description = "A list of egress rules in a security group."
  type        = any
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
