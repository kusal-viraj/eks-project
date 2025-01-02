

resource "aws_db_subnet_group" "main_rds_dbsubnet_group" {
  name       = "${var.env_name}-db-subnet-group"
  subnet_ids = var.private_rds_subnet_ids

  tags = {
    Name        = "${var.env_name}-db-subnet-group"
    Env         = var.env_name
#    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  description = "Database subnet group for ${var.env_name} environment."
}

## source = "../Aws-Modules/modules/rds/rds.tf"
## RDS

#=======================================================================

resource "aws_db_instance" "rds" {
  identifier              = "${var.env_name}-rds-instance"
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  port                    = var.rds_db_port
  db_subnet_group_name    = aws_db_subnet_group.main_rds_dbsubnet_group.name
  vpc_security_group_ids  = [var.rds_sg_id]

  skip_final_snapshot     = var.skip_final_snapshot
  publicly_accessible     = false

  # Storage options
  storage_type            = var.storage_type
  multi_az                = var.multi_az
  backup_retention_period = var.backup_retention
  storage_encrypted       = true

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [engine_version]
  }

  tags = {
    Name                  = "${var.env_name}-rds-instance"
    Env                   = var.env_name
  }

  depends_on = [aws_db_subnet_group.main_rds_dbsubnet_group]
}
