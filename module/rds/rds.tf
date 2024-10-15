

resource "aws_db_subnet_group" "main_rds_dbsubnet_group" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = var.private_rds_subnet_ids

  tags = {
    Name        = "${var.env}-db-subnet-group"
    Environment = var.env
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  description = "Database subnet group for ${var.env} environment."
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.env}-rds-sg"
  description = "RDS Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.backend_subnet_cidrs

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.env}-rds-sg"
    Environment = var.env
  }
}



resource "aws_db_instance" "rds" {
  identifier          = "${var.env}-rds-instance"
  allocated_storage   = var.allocated_storage
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  username            = var.username
  password            = var.password
  port                = var.port
  db_subnet_group_name = aws_db_subnet_group.main_rds_dbsubnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = var.skip_final_snapshot
  publicly_accessible = false

  # Storage options
  storage_type        = var.storage_type
  multi_az            = var.multi_az
  backup_retention_period = var.backup_retention
  storage_encrypted           = true

  tags = {
    Name        = "${var.env}-rds-instance"
    Environment = var.env
  }

  depends_on = [aws_db_subnet_group.main_rds_dbsubnet_group]
}
