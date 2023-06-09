# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
}

variable "environment" {
  description = "The name of the environment"
}

variable "client_name" {
  description = "Name of the project being built"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
}
