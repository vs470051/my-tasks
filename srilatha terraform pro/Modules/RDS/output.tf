output "db_instance_address" {

  description = "The address of the RDS instance"

  value       =  aws_db_instance.wordpressdb.address

}

output "db_instance_availability_zone" {

description = "The availability zone of the RDS instance"

value = aws_db_instance.wordpressdb.availability_zone

}

output "db_instance_endpoint" {

description = "The connection endpoint"

value = aws_db_instance.wordpressdb.endpoint

}



output "db_instance_id" {

description = "The RDS instance ID"

value = aws_db_instance.wordpressdb.id

}

output "db_instance_name" {

description = "The database name"

value = aws_db_instance.wordpressdb.db_name

}



output "db_instance_port" {

description = "The database port"

value = aws_db_instance.wordpressdb.port

}



