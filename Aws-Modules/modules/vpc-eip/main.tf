resource "aws_eip" "eip_for_nat_az1" {
  domain = "vpc"

  tags = {
    Name = "${var.env_name}-nat-eip-az1"
    Env  = var.env_name
  }
}

resource "aws_eip" "eip_for_nat_az2" {
  domain = "vpc"

  tags = {
    Name = "${var.env_name}-nat-eip-az2"
    Env  = var.env_name
  }
}

