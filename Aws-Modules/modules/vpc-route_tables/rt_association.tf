resource "aws_route_table_association" "main_bastion_subnet_association" {
  subnet_id      = var.bastion_subnet_id
  route_table_id = aws_route_table.main_public_rt.id
}

resource "aws_route_table_association" "main_public_subnet_1_association" {
  subnet_id      = var.public_subnet_az1_id
  route_table_id = aws_route_table.main_public_rt.id
}

resource "aws_route_table_association" "main_public_subnet_2_association" {
  subnet_id      = var.public_subnet_az2_id
  route_table_id = aws_route_table.main_public_rt.id
}

resource "aws_route_table_association" "main_private_app_subnet_1_association" {
  subnet_id      = var.app_subnet_az1_id
  route_table_id = aws_route_table.main_private_rt_1.id
}

resource "aws_route_table_association" "main_private_app_subnet_2_association" {
  subnet_id      = var.app_subnet_az2_id
  route_table_id = aws_route_table.main_private_rt_2.id
}

resource "aws_route_table_association" "main_private_rds_subnet_1_association" {
  subnet_id      = var.rds_subnet_az1_id
  route_table_id = aws_route_table.main_private_rt_1.id
}

resource "aws_route_table_association" "main_private_rds_subnet_2_association" {
  subnet_id      = var.rds_subnet_az2_id
  route_table_id = aws_route_table.main_private_rt_2.id
}
