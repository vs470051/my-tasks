

resource "aws_db_instance" "wordpressdb" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
#   parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az = var.multi_az
  
}