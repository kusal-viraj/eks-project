module "security_group" {
  source = "../../modules/vpc-security_groups"

  vpc_id         = module.vpc.vpc_id # Replace with your VPC ID
  vpn_ip         = var.vpn_ip
  env_name       = var.env_name
  cluster_name   = var.cluster_name
  vpc_cidr_block = var.vpc_cidr

  app_subnet_1_cidr_block   = var.private_app_subnet_az1_cidr
  app_subnet_2_cidr_block   = var.private_app_subnet_az2_cidr

  rds_subnet_1_cidr_block   = var.private_rds_subnet_az1_cidr
  rds_subnet_2_cidr_block   = var.private_rds_subnet_az2_cidr

  proxy_service_port        = var.proxy_service_port
  auth_service_port         = var.auth_service_port
  vp_service_port           = var.vp_service_port
  umm_service_port          = var.umm_service_port
  tenant_service_port       = var.tenant_service_port
  integration_service_port  = var.integration_service_port
  common_service_port       = var.common_service_port
  message_service_port      = var.message_service_port
  payment_service_port      = var.payment_service_port

  bcc_service_port          = var.bcc_service_port
  qbo_service_port          = var.qbo_service_port

  usb_service_port          = var.usb_service_port
  notification_service_port = var.notification_service_port
  checkeeper_service_port   = var.checkeeper_service_port

  rds_db_port = var.db_rds_db_port

  control_plane_security_group_id = module.eks.control_plane_security_group_id


}
