
variable "Bucket_name" {
  type        = string
  description = "Name of the bucket"
}

variable "force_destroy" {
  type        = bool
  description = " to destroy the objects with the bucket or not"
}