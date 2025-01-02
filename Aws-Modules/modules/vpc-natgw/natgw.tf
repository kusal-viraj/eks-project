
## source = "../Aws-Modules/modules/vpc-natgw/natgw.tf"
## Nat Gateways

#=======================================================================

resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = var.eip_nat_az1
  subnet_id     = var.public_subnet_az1_id

  tags = {
    Name = "${var.env_name}-nat-gateway-az1"
    Env  = var.env_name
  }

}

resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = var.eip_nat_az2
  subnet_id     = var.public_subnet_az2_id

  tags = {
    Name = "${var.env_name}-nat-gateway-az2"
    Env  = var.env_name
  }
}
