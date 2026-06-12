variable "rds_instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "username" {
  type      = string
  sensitive = true
}

variable "environment" {
  type = string
}

variable "vpc_security_group_ids" {
  type = set(string)
}

variable "subnet_ids" {
  type = set(string)
}

variable "rds_db_name" {
  type = string
}