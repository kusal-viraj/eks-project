output "instance_id" {
  value = aws_instance.bastion_instance.id
}

output "ssh_Instance_public_IP" {
  value = aws_instance.bastion_instance.public_ip
}
