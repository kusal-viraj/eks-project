output "public-subnet-bastion-az_01_id" {
    value = aws_subnet.public_subnet_bastion_az_01.id
    //value = var.public-bastian-subnet-cidr-az_01
}

output "public-subnet-bastion-az_01_cidr" {
    value = aws_subnet.public_subnet_bastion_az_01.cidr_block
    //value = var.public-bastian-subnet-cidr-az_01
}

output "public_subnet_az_01_id" {
    value = aws_subnet.web_public_subnet_az1.id
}

output "public_subnet_az_02_id" {
    value = aws_subnet.web_public_subnet_az2.id
}

output "backend_private_subnet_az_01_id" {
    value = aws_subnet.backend_private_subnet_01.id
}

output "backend_private_subnet_az_02_id" {
    value = aws_subnet.backend_private_subnet_02.id
}

output "rds_private_subnet_az_01_id" {
    value = aws_subnet.rds_private_subnet_01.id
}

output "rds_private_subnet_az_02_id" {
    value = aws_subnet.rds_private_subnet_02.id
}


output "efs_subnet_ids" {
    value = [
        aws_subnet.backend_private_subnet_01.id,
        aws_subnet.backend_private_subnet_02.id
        ]
}

output "alb_subnet_ids" {
    value = [
        aws_subnet.web_public_subnet_az1,
        aws_subnet.web_public_subnet_az2
    ]
}
