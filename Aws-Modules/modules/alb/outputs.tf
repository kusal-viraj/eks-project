output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.application_lb.dns_name
}


output "alb_arn_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.application_lb.arn
}

output "alb_targetgroup_arn" {
  description = "The DNS name of the ALB"
  value       = aws_lb_target_group.app_target_group.arn
}
