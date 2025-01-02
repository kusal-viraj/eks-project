
## source = "../Aws-Modules/modules/vpc-igw/igw.tf"
## Internet Gateway Declaration

#=======================================================================

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name  = "${var.env_name}-igw"
    vpc   = var.vpc_name
    Env   = var.env_name
  }

}
