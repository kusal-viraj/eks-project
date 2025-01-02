
## source = "../Aws-Modules/modules/vpc-subnets/subnets.tf"
## Subnets

#======================================================================

data "aws_availability_zones" "available_zone" {}

resource "aws_subnet" "public_subnet_bastion_az_01" {

  vpc_id     = var.vpc_id
  cidr_block = var.public_bastion_subnet_az_01_cidr
  availability_zone = data.aws_availability_zones.available_zone.names[0]
  map_public_ip_on_launch = true

  tags = {
    #Name = "${var.env_name}-public-subnet-bastian-az1"
    Name = "${var.env_name}-SSH-subnet"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "web_public_subnet_az1"{
  vpc_id      = var.vpc_id
  cidr_block  =var.web_public_subnet_az1_cidr
  availability_zone = data.aws_availability_zones.available_zone.names[0]
  map_public_ip_on_launch = true

  tags = {
    #Name = "${var.env_name}-public-subnet-az1"
    Name = "${var.env_name}-WEB-Subnet-01-az1"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"

  }
}

resource "aws_subnet" "web_public_subnet_az2"{
  vpc_id      = var.vpc_id
  cidr_block  =var.web_public_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.available_zone.names[1]
  map_public_ip_on_launch = true

  tags = {
    #Name = "${var.env_name}-public-subnet-az2"
    Name = "${var.env_name}-WEB-Subnet-02-az2"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"

  }
}

resource "aws_subnet" "backend_private_subnet_01"{
  vpc_id      = var.vpc_id
  cidr_block  =var.private_app_subnet_az1_cidr
  availability_zone = data.aws_availability_zones.available_zone.names[0]
  map_public_ip_on_launch = false

  tags = {
    #Name = "${var.env_name}-private-subnet-az1"
    Name = "${var.env_name}-APP-subnet-01-az1"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"

  }
}

resource "aws_subnet" "backend_private_subnet_02"{
  vpc_id      = var.vpc_id
  cidr_block  =var.private_app_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.available_zone.names[1]
  map_public_ip_on_launch = false

  tags = {
    #Name = "${var.env_name}-private-subnet-az2"
    Name = "${var.env_name}-APP-subnet-02-az2"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"

  }
}

resource "aws_subnet" "rds_private_subnet_01"{
  vpc_id      = var.vpc_id
  cidr_block  =var.private_rds_subnet_az1_cidr
  availability_zone = data.aws_availability_zones.available_zone.names[0]
  map_public_ip_on_launch = false

  tags = {
    #Name = "${var.env_name}-private-subnet-az1"
    Name = "${var.env_name}-RDS-subnet-01-az1"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"

  }
}

resource "aws_subnet" "rds_private_subnet_02"{
  vpc_id      = var.vpc_id
  cidr_block  =var.private_rds_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.available_zone.names[1]
  map_public_ip_on_launch = false

  tags = {
    #Name = "${var.env_name}-private-subnet-az2"
    Name = "${var.env_name}-RDS-subnet-02-az2"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"

  }
}


