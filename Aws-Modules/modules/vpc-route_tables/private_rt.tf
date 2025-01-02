
## source = "../Aws-Modules/modules/vpc-route_tables/private_rt.tf"
## Private Route Tables For private subnets

#=======================================================================

resource "aws_route_table" "main_private_rt_1" {

  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_az1_id
  }

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.env_name}_private_rt_1"
    Env  = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_route_table" "main_private_rt_2" {

  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_az2_id
  }

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.env_name}_private_rt_2"
    Env  = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}
