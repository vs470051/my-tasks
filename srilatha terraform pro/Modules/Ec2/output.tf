

output "server_private_ip" {
value = aws_instance.webserver[*].private_ip
}
output "server_public_ipv4" {
value = aws_instance.webserver[*].public_ip
}
output "server_id" {
value = aws_instance.webserver
}

output "public_dns" {
  value = aws_instance.webserver[*].public_dns
}
output "tls_private_key"{
value = tls_private_key.rsa.private_key_pem
}