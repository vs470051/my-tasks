
variable "allocated_storage" {
  type = number
  description = "storage for the db"
}

variable "db_name" {
  type = string
  description = "Name of the db"
}

variable "engine" {
  type = string
  description = "DB engine"
}

variable "engine_version" {
  type = string
  description = "Engine version"
}

variable "instance_class" {
  type = string
  description = "Instance class"
}

variable "username" {
    type = string
    description = "username"
}

variable "password" {
    type = string
    description = "password for the db"
}


variable "multi_az" {
  type = bool
  description = "to enable multi-az or not"
}

# variable "security_group_id" {
#   type = list(string)
#   description = "security group id"
# }