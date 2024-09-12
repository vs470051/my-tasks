

output "ALB_security_group_id" {
  value = aws_security_group.wordpress_ALB_securitygroup.id
}

output "Ec2_secuirty_group_id" {
  value = aws_security_group.wordpress_EC2_securitygroup.id
}