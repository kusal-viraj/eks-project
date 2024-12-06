output name {
  value       = var.region
  //sensitive   = true
  //description = "description"
  //depends_on  = []
}

output "vpc_id"{
    value =aws_vpc.main_vpc.id
}

