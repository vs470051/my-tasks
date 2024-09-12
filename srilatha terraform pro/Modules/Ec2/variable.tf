

variable "security_group_id" {
#   type = list()
  description = "security group id's"
}

variable "subnet_id" {
#   type = list()
  description = "subnet id's"
}

variable "Count" {
    type = number
    description = "Number of instance to be created"
}
variable "ami" {
    type =  string
    description = "Amazon machine image id"
}
variable "instance_type" {
    type = string
    description = "instance to be created"
}
variable "key_name" {
    type = string
    description = "name of the key"
}

variable "filename" {
  type = string
  description = "Name of the private key file"
}

variable "instance_name" {
  description = "Name of the instances"
}




