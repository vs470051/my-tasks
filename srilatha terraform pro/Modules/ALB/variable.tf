
variable "Load_balancer_name" {
  type = string
}

variable "security_group" {
  description = "secuirty group that will attached to loadbalancer"
}

variable "subnet" {
  description = "Subnet that Load balancer send traffic"
}

variable "deletion_protection" {
  type        = bool
  description = "enable deleteion protection for Load balancer"
}

variable "bucket_name" {
  type        = string
  description = "bucket logs for access logs storage"
}

variable "enable_access_logs" {
  type = bool
}

variable "Tags_environment" {
  type        = string
  description = "Tag valuefor the Load balancer"
}

variable "Targetgroup_name" {
  type        = string
  description = "Name of the target group name"
}

variable "VPC_ID" {
  description = "VPC ID for the Target group"
}

variable "TG_healthcheckPath" {
  type        = string
  description = "path for the health check"
}

variable "TG_port" {
  type        = number
  description = "port for the target group"
}

variable "TG_protocol" {
  type        = string
  description = "protocol for the Target group"
}

variable "TG_ID" {
  description = "targetid for the target group attachment"
}


variable "listener_port" {
  type        = number
  description = "Port for the ALB listner"
}

variable "listener_protocol" {
  type        = string
  description = "protocol for the ALB listner"
}

