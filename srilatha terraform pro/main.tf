

module "VPC" {
  source            = "./modules/vpc"
  Subnet_Count      = 2
  vpc_cidr          = "10.0.0.0/25"
  Subnet_CIDR_block = ["10.0.0.0/26", "10.0.0.64/26"]
  Subnet_name       = ["wordpress1", "wordpress2"]

}

module "security_group" {
  source          = "./modules/securitygroups"
  Number_of_rules = 2
  ip_protocol     = ["tcp", "tcp"]
  from_port       = [80, 443]
  to_port         = [80, 443]
  ipv4_range      = ["0.0.0.0/0", "0.0.0.0/0"]
  vpc_id          = module.VPC.VPC_ID
}

module "S3_bucket" {
  source        = "./modules/s3"
  Bucket_name   = "wordpress"
  force_destroy = true
}


module "Ec2_instance" {
  source            = "./Modules/Ec2"
  Count             = 2
  ami               = "ami-0e47b53f2cc9c2721" 
  instance_type     = "t2.micro"
  key_name          = "wordpress_key"
  filename          = "wordpress_instance"
  instance_name     = ["Wordpress1", "wordpress2"]
  security_group_id = [module.security_group.Ec2_secuirty_group_id]
  subnet_id         = [for subnet in module.VPC.subnet_id : subnet.id]
}

module "ALB" {
  source              = "./Modules/ALB"
  Load_balancer_name  = "Wordpress-loadbalancer"
  security_group      = [module.security_group.ALB_security_group_id]
  subnet              = [for subnet in module.VPC.subnet_id : subnet.id]
  TG_ID               = [for instance in module.Ec2_instance.server_id : instance]
  VPC_ID              = module.VPC.VPC_ID
  deletion_protection = false
  bucket_name         = module.S3_bucket.s3_bucketname
  enable_access_logs  = false
  Tags_environment    = "test"
  Targetgroup_name    = "webserver-target"
  TG_port             = 80
  TG_protocol         = "HTTP"
  TG_healthcheckPath  = "/"
  listener_port       = 80
  listener_protocol   = "HTTP"

}

module "RDS" {
  source = "./Modules/RDS"
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  multi_az = true
}