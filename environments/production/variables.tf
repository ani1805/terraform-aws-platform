variable "vpc_cidr" {
    type = string
}

variable "environment" {
    type = string
}

variable "aws_region" {
    type = string
}

variable "public_subnet_cidr" {
    type = string
}

variable "private_subnet_cidr" {
    type = string
}

variable "private_subnet_2_cidr" {
    type = string
}

variable "availability_zone_1" {
    type = string
}

variable "availability_zone_2" {
    type = string
}

variable "allowed_cidr_block_for_ssh" {
    type = string
  
}

variable "ami_id" {
    type = string
}

variable "ec2_instance_type" {
    type = string
}

variable "key_pair_name" {
    type = string 
}

variable "rds_allocated_storage" {
    type = number
}

variable "rds_instance_class" {
    type = string
}

variable "rds_username" {
    type = string
    sensitive = true
}

variable "rds_password" {
    type = string
    sensitive = true
}

variable "rds_db_name" {
    type = string 
}
