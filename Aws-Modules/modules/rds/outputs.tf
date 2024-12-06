output "rds_endpoint" {
  description = "The ID of the security group."
  value       = aws_db_instance.rds.endpoint
}

