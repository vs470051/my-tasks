

variable "Number_of_rules" {
  type        = number
  description = "Number of ingress rules to be created"
}

variable "ipv4_range" {
  type        = list(string)
  description = "List of ipv4 ranges for the ingress rules"
}

variable "from_port" {
  type        = list(number)
  description = "starting range of the port"
}

variable "to_port" {
  type        = list(number)
  description = "ending range of the port"
}

variable "ip_protocol" {
  type        = list(string)
  description = "protocols list"
}

variable "vpc_id" {
  description = "vpc id"
}