

output "ALB_DNS" {
  value = module.ALB.ALB_DNS
}

output "EC2_IP" {
    value = module.Ec2_instance.server_public_ipv4[*]
}

output "RDS_Endpoint" {
  value = module.RDS.db_instance_endpoint
}

