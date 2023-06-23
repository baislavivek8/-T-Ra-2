variable "vpc_id" {
  description = "VPC ID"
}

variable "client_name" {
  description = "Name of the project being built"
  default = "default"
}

variable "instance_count" {
  description = "Number of AZs to cover in a given region"
  default = 2
}
variable "environment" {
  description = "The name of the environment"
}
variable "aws_public_subnet" {
  description = "list aws public subnet IDs"
}

variable "aws_private_subnet" {
  description = "list aws private subnet IDs"
}
variable "ami_id" {}
variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "172.17.0.0/16"
}
