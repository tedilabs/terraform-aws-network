output "id" {
  description = "The ID of the security group."
  value       = aws_security_group.this.id
}

output "arn" {
  description = "The ARN of the security group."
  value       = aws_security_group.this.arn
}

output "name" {
  description = "The name of the security group."
  value       = aws_security_group.this.name
}

output "description" {
  description = "The description of the security group."
  value       = aws_security_group.this.description
}

output "owner_id" {
  description = "The ID of the AWS account that owns the security group."
  value       = aws_security_group.this.owner_id
}

output "vpc_id" {
  description = "The ID of the associated VPC."
  value       = aws_security_group.this.vpc_id
}

output "ingress_rules" {
  description = <<EOF
  The configuration of the security group ingress rules.
  EOF
  value = {
    for name, rule in aws_vpc_security_group_ingress_rule.this :
    name => {
      id          = rule.id
      arn         = rule.arn
      description = rule.description

      protocol  = rule.ip_protocol
      from_port = rule.from_port
      to_port   = rule.to_port
    }
  }
}

output "egress_rules" {
  description = <<EOF
  The configuration of the security group egress rules.
  EOF
  value = {
    for name, rule in aws_vpc_security_group_egress_rule.this :
    name => {
      id          = rule.id
      arn         = rule.arn
      description = rule.description

      protocol  = rule.ip_protocol
      from_port = rule.from_port
      to_port   = rule.to_port
    }
  }
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
