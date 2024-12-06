resource "aws_vpc" "main_vpc" {
  cidr_block            = var.vpc_cidr
  enable_dns_support    = true
  enable_dns_hostnames  = true
  instance_tenancy      = var.vpc_tenancy

  tags = {
    Name = var.vpc_name
    Env  = var.env_name
  }
}


/*data "aws_availability_zones" "available_zone" {}

resource "aws_subnet" "public-subnet-az_01" {
  vpc_id     = aws_vpc.qa-main.id
  cidr_block = var.public_bastian_subnet_cidr_az_01
  availability_zone = data.aws_availability_zones.available_zone.names[0]
  map_public_ip_on_launch = true



  tags = {
    Name = "qa-public-bastian-subnet_01"
  }
}
*/
