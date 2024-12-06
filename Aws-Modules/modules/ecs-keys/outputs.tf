
output "public_key" {
 value = tls_private_key.ssh_key.public_key_openssh
}

output "private_key_pem" {
 value = tls_private_key.ssh_key.private_key_pem
 sensitive = true
}

output "key_name" {
 value = aws_key_pair.generated_key.key_name
}
