

resource "aws_lb" "Load_balancer" {
  name                       = var.Load_balancer_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.security_group
  subnets                    = var.subnet
  enable_deletion_protection = var.deletion_protection


  access_logs {
    bucket  = var.bucket_name
    prefix  = "word-press-lb"
    enabled = var.enable_access_logs
  }
  tags = {
    Environment = var.Tags_environment
  }
}


resource "aws_lb_target_group" "taretgroup" {

  name     = var.Targetgroup_name
  port     = var.TG_port
  protocol = var.TG_protocol
  vpc_id   = var.VPC_ID

  health_check {
    path = var.TG_healthcheckPath
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "TG_attachment" {
  
  count = length(var.TG_ID)
  target_group_arn = aws_lb_target_group.taretgroup.arn
  target_id        = var.TG_ID[count.index].id
  port             = var.TG_port
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.Load_balancer.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.taretgroup.arn
  }
}