

output "ALB_DNS" {
  value = aws_lb.Load_balancer.dns_name
}