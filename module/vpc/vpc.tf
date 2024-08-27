#./module/vpc/vpc.tf

# Retrieve available availability zones
data "aws_availability_zones" "available" {}

locals {
  cluster_name = var.cluster_name
  # Specify the AZs you want to use (A and B in this case)
  desired_azs = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]  # AZ A and B
}

## VPC Declaration--------------------------------------------------------
resource "aws_vpc" "main_vpc"{
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name = var.vpc_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

##---------------------------------------------------------------------------


##-----------Internet Gateway------------------------------------------------
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.igw_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  depends_on = [aws_vpc.main_vpc]
}

#resource "aws_vpc_attachment" "attach_igw" {
#  vpc_id = aws_vpc.main_vpc.id
#  internet_gateway_id = aws_internet_gateway.main_igw.id
#}

##--------------------------------------------------------------------------


##------------Subnets------------------------------------------------------

resource "aws_subnet" "main_bastion_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.bastion_subnet_cidr
  availability_zone = local.desired_azs[0]# AZ A
  map_public_ip_on_launch = true

  tags = {
    Name = var.bastion_subnet_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "main_public_subnet_1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = local.desired_azs[0]  # AZ A
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_1_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"

  }
  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "main_public_subnet_2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = local.desired_azs[1]  # AZ B
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_2_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "main_private_app_subnet_1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_app_subnet_1_cidr
  availability_zone = local.desired_azs[0]  # AZ A

  tags = {
    Name = var.private_app_subnet_1_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "main_private_app_subnet_2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_app_subnet_2_cidr
  availability_zone = local.desired_azs[1]  # AZ B

  tags = {
    Name = var.private_app_subnet_2_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "main_private_rds_subnet_1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_rds_subnet_1_cidr
  availability_zone = local.desired_azs[0]  # AZ A

  tags = {
    Name = var.private_rds_subnet_1_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "main_private_rds_subnet_2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_rds_subnet_2_cidr
  availability_zone = local.desired_azs[1]  # AZ B

  tags = {
    Name = var.private_rds_subnet_2_name
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  depends_on = [aws_vpc.main_vpc]
}

##---------------------------------------------------------------------

##--------------Route Tables-------------------------------------------

resource "aws_route_table" "main_public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  route {
    cidr_block = "10.50.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = var.public_rt
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_route_table" "main_private_rt_1" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat_gw_1.id
  }
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_nat_gateway.main_nat_gw_2.id
#  }
  route {
    cidr_block = "10.50.0.0/16"
    gateway_id = "local"
  }



  tags = {
    Name = var.private_rt_1
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_route_table" "main_private_rt_2" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat_gw_2.id
  }

  route {
    cidr_block = "10.50.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = var.private_rt_2
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_route_table_association" "main_bastion_subnet_association" {
  subnet_id      = aws_subnet.main_bastion_subnet.id
  route_table_id = aws_route_table.main_public_rt.id
}

resource "aws_route_table_association" "main_public_subnet_1_association" {
  subnet_id      = aws_subnet.main_public_subnet_1.id
  route_table_id = aws_route_table.main_public_rt.id
}

resource "aws_route_table_association" "main_public_subnet_2_association" {
  subnet_id      = aws_subnet.main_public_subnet_2.id
  route_table_id = aws_route_table.main_public_rt.id
}

resource "aws_route_table_association" "main_private_app_subnet_1_association" {
  subnet_id      = aws_subnet.main_private_app_subnet_1.id
  route_table_id = aws_route_table.main_private_rt_1.id
}

resource "aws_route_table_association" "main_private_app_subnet_2_association" {
  subnet_id      = aws_subnet.main_private_app_subnet_2.id
  route_table_id = aws_route_table.main_private_rt_2.id
}

resource "aws_route_table_association" "main_private_rds_subnet_1_association" {
  subnet_id      = aws_subnet.main_private_rds_subnet_1.id
  route_table_id = aws_route_table.main_private_rt_1.id
}

resource "aws_route_table_association" "main_private_rds_subnet_2_association" {
  subnet_id      = aws_subnet.main_private_rds_subnet_2.id
  route_table_id = aws_route_table.main_private_rt_2.id
}


##-----------EIPS For NATS---------------------------------------------------------

resource "aws_eip" "main_eip_1" {
  domain = "vpc"

  tags = {
    Name                                          = var.eip_1
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_eip" "main_eip_2" {
  domain = "vpc"

  tags = {
    Name                                          = var.eip_2
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}
#------------------------------------------------------------------------


##--------------Nat Gateways---------------------------------------------

resource "aws_nat_gateway" "main_nat_gw_1" {
  allocation_id = aws_eip.main_eip_1.id
  subnet_id     = aws_subnet.main_public_subnet_1.id

  tags = {
    Name = var.nat_gw_1
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"

  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main_igw]
}

resource "aws_nat_gateway" "main_nat_gw_2" {
  allocation_id = aws_eip.main_eip_2.id
  subnet_id     = aws_subnet.main_public_subnet_2.id

  tags = {
    Name = var.nat_gw_2
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"

  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main_igw]
}
#--------------------------------------------------------------------------------------

##----------------Network Acl---------------------------------------------------------

resource "aws_network_acl" "main_bastion_nacl" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    #cidr_block = "18.119.125.54/32"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "-1"
    rule_no    = 99
    action     = "allow"
    #cidr_block = "18.119.125.54/32"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "tcp"
    rule_no    = 201
    action     = "allow"
    cidr_block = "10.50.0.0/16"
    from_port  = 22
    to_port    = 22
  }


  tags = {
    Name                                          = var.bastion_nacl
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_network_acl_association" "bastion_nacl_association" {
  subnet_id      = aws_subnet.main_bastion_subnet.id
  network_acl_id = aws_network_acl.main_bastion_nacl.id
}

resource "aws_network_acl" "main_public_nacl" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "10.50.10.0/24"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    #description = "Allow EKS control plane to communicate with nodes"
    rule_no    = 104
    action     = "allow"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_block = aws_vpc.main_vpc.cidr_block # Only allow traffic from within the VPC
  }

  ingress {
    protocol   = "-1"
    rule_no    = 105
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 202
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name                                          = var.public_nacl
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_network_acl" "main_private_app_nacl" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 106
    action     = "allow"
    cidr_block = "10.50.11.0/24"
    from_port  = 7000
    to_port    = 7000
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 107
    action     = "allow"
    cidr_block = "10.50.10.0/24"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    #description = "Allow EKS control plane to communicate with nodes"
    rule_no    = 108
    action     = "allow"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_block = aws_vpc.main_vpc.cidr_block # Only allow traffic from within the VPC
  }

  ingress {
    #description = "Allow EKS API server to communicate with nodes"
    rule_no    = 109
    action     = "allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = aws_vpc.main_vpc.cidr_block # Only allow traffic from within the VPC
  }

  ingress {
    protocol   = "-1"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 202
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name                                          = var.private_app_nacl
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_network_acl" "main_private_rds_nacl" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 111
    action     = "allow"
    cidr_block = "10.50.21.0/24"
    from_port  = 3306
    to_port    = 3306
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 112
    action     = "allow"
    cidr_block = "10.50.10.0/24"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "-1"
    rule_no    = 113
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 202
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name                                          = var.private_rds_nacl
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}


resource "aws_network_acl_association" "public_nacl_association_1" {
  subnet_id      = aws_subnet.main_public_subnet_1.id
  network_acl_id = aws_network_acl.main_public_nacl.id
}

resource "aws_network_acl_association" "public_nacl_association_2" {
  subnet_id      = aws_subnet.main_public_subnet_2.id
  network_acl_id = aws_network_acl.main_public_nacl.id
}

resource "aws_network_acl_association" "private_app_nacl_association_1" {
  subnet_id      = aws_subnet.main_private_app_subnet_1.id
  network_acl_id = aws_network_acl.main_private_app_nacl.id
}

resource "aws_network_acl_association" "private_app_nacl_association_2" {
  subnet_id      = aws_subnet.main_private_app_subnet_2.id
  network_acl_id = aws_network_acl.main_private_app_nacl.id
}

resource "aws_network_acl_association" "private_rds_nacl_association_1" {
  subnet_id      = aws_subnet.main_private_rds_subnet_1.id
  network_acl_id = aws_network_acl.main_private_rds_nacl.id
}

resource "aws_network_acl_association" "private_rds_nacl_association_2" {
  subnet_id      = aws_subnet.main_private_rds_subnet_2.id
  network_acl_id = aws_network_acl.main_private_rds_nacl.id
}

#---------------------NACL End---------------------------------------------------

##---------------------security groups------------------------------------------

resource "aws_security_group" "bastion_sg" {


  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks      = [var.vpn_ip]
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name                                          = var.bastion_sg_name
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}





##-----------------bastion ec2 Deployement-----------------------------------------

resource "aws_instance" "bastion_instance" {
  ami                    = var.bastion_ami_id                       # Replace with the AMI ID you want to use
  instance_type          = var.bastion_instance_type                # Replace with your desired instance type (e.g., "t2.micro")
  subnet_id              = aws_subnet.main_bastion_subnet.id # This refers to the Bastion subnet you defined earlier
  key_name               = var.Bastion_key_name                     # The name of the key pair to use for SSH access
  associate_public_ip_address = true                        # Ensure the instance has a public IP
  vpc_security_group_ids       = [aws_security_group.bastion_sg.id]  # Reference the security group here

  tags = {
    Name                                          = var.bastion_instance_name # Replace with the desired instance name
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  # Ensure the instance is created after the subnet and security groups
  depends_on = [aws_subnet.main_bastion_subnet, aws_security_group.bastion_sg]
}
