

output "VPC_ID" {
  value = aws_vpc.wordpress_vpc.id
}

output "subnet_id" {
  
  value = aws_subnet.subnets
}



