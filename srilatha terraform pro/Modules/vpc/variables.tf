

variable "vpc_cidr" {
  type        = string
  description = "CIDR value for the Vpc"
}

variable "Subnet_Count" {
  type        = number
  description = "Count of the Number of subnets to be created"
}

variable "Subnet_CIDR_block" {
  type        = list(string)
  description = "List of the cidr value for the subnet"
}

variable "Subnet_name" {
  type = list(string)
  description = "List of the names of the subnet"
}



