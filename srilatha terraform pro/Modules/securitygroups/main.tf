

resource "aws_security_group" "wordpress_ALB_securitygroup" {

  name        = "ALB_Word_press"
  description = "Security group for the ALB"
  vpc_id      = var.vpc_id
  tags = {
    Name = "Word_press_rules for ALB"
  }
}

resource "aws_security_group" "wordpress_EC2_securitygroup" {
  name = "wordpress"
  description = "Security group for the Instance "
  vpc_id = var.vpc_id
  tags = {
    Name = "word_press_rules for ec2"
  }
}


resource "aws_security_group_rule" "ALB" {
  count = var.Number_of_rules
  type              = "ingress"
  from_port         = var.from_port[count.index]
  to_port           = var.to_port[count.index]
  protocol          = var.ip_protocol[count.index]
  cidr_blocks       = [var.ipv4_range[count.index]]
  security_group_id = aws_security_group.wordpress_ALB_securitygroup.id
}

resource "aws_security_group_rule" "ALB_allowall" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  security_group_id = aws_security_group.wordpress_ALB_securitygroup.id
  # prefix_list_ids = []
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2instance" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  source_security_group_id = aws_security_group.wordpress_ALB_securitygroup.id
  security_group_id = aws_security_group.wordpress_EC2_securitygroup.id
}

resource "aws_security_group_rule" "EC2_allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  security_group_id = aws_security_group.wordpress_EC2_securitygroup.id
  cidr_blocks = ["0.0.0.0/0"]
  # prefix_list_ids = []
}