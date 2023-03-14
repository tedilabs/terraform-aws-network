output "id" {
  description = "The ID of the reachability analyzer path."
  value       = aws_ec2_network_insights_path.this.id
}

output "arn" {
  description = "The ARN of the reachability analyzer path."
  value       = aws_ec2_network_insights_path.this.arn
}

output "name" {
  description = "The name of the reachability analyzer path."
  value       = local.metadata.name
}

output "protocol" {
  description = "The protocol to use for analysis."
  value       = upper(aws_ec2_network_insights_path.this.protocol)
}

output "source_network" {
  description = "The configuration of source network for analysis."
  value = {
    id         = aws_ec2_network_insights_path.this.source
    ip_address = aws_ec2_network_insights_path.this.source_ip
  }
}

output "destination_network" {
  description = "The configuration of destination network for analysis."
  value = {
    id         = aws_ec2_network_insights_path.this.destination
    ip_address = aws_ec2_network_insights_path.this.destination_ip
    port       = aws_ec2_network_insights_path.this.destination_port
  }
}

output "analyses" {
  description = "A list of histories of the analysis with the reachability analyzer path."
  value = [
    for name, analysis in aws_ec2_network_insights_analysis.this : {
      name = name
      id   = analysis.id
      arn  = analysis.arn

      path_found = analysis.path_found
      status     = analysis.status
      started_at = analysis.start_date

      # INFO: https://docs.aws.amazon.com/vpc/latest/reachability/explanation-codes.html
      explanation_codes = [
        for explanation in analysis.explanations :
        explanation.explanation_code
      ]
      # status_message = analysis.status_message
      # warning_message = analysis.warning_message

      forward_path_components = [
        for c in analysis.forward_path_components :
        one(c.component)
      ]
      return_path_components = [
        for c in analysis.return_path_components :
        one(c.component)
      ]
    }
  ]
}
