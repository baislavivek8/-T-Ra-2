# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default = "us-west-2"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default = "2"
}

variable "environment" {
  description = "The name of the environment"
}

variable "client_name" {
  description = "Name of the project being built"
  default = "default"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "aws_natgateway_ips" {
  description = "list aws nat gateways public ips"
}

variable "aws_public_subnet" {
  description = "list aws public subnet IDs"
}

variable "aws_private_subnet" {
  description = "list aws private subnet IDs"
}

variable "account_id" {
  description = "AWS Account ID"
}

variable "alb_account_id" {
  description = "Alb account ID wrt. aws regions"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "172.17.0.0/16"
}

variable "vpn_port_22_security_group_id" {
  description = ""
}

variable "db_instance_class" {
  description = ""
}

variable "db_port" {
  description = "RDS Mysql Port"
  default = 3306
}

variable "master_user" {
  description = "RDS Master User Name"
}

variable "master_password" {
  description = "RDS Master Password "
}

variable "max_prepared_transactions" {
  description = " Value for max_prepared_transactions postgresql parameter"
  default = 32
}

variable "max_connections" {
  description = " Value for max_prepared_transactions postgresql parameter"
}

variable "work_mem" {
  description = " Value for max_prepared_transactions postgresql parameter"
}

variable "audit_trail_enabled" {
  description = "Flag to enable audit trail"
}


variable "domain_name" {
  description = "Domain Name to be used"
}

variable "ami_id" {}