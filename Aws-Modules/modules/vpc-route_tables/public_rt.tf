
## source = "../Aws-Modules/modules/vpc-route_tables/public_rt.tf"
## Public Route Tables For public subnets

#=======================================================================

resource "aws_route_table" "main_public_rt" {

  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.env_name}_public_rt"
    Env  = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}
