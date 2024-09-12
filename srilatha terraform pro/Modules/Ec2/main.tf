
resource "aws_key_pair" "wordpress-key-pair" {
key_name = var.key_name
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}

resource "local_file" "wordpress-key" {
content  = tls_private_key.rsa.private_key_pem
filename = var.filename
}

resource "aws_instance" "webserver" {
 count = var.Count
 ami                    = var.ami
 instance_type          = var.instance_type
 key_name = var.key_name
 vpc_security_group_ids = var.security_group_id
 subnet_id = var.subnet_id[count.index]
 associate_public_ip_address = true
 tags = {
   Name = "${var.instance_name[count.index]}"
 }
 
user_data = "${file("./scripts/instance.sh")}"
} 