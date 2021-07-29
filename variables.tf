# variables.tf

variable "aws_region" {
  description = "The AWS region resources are created in"
  default = "us-west-2"
}

variable "aws_peer_region" {
  description = "The AWS region things are created in"
  default = "us-east-1"
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

variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "172.17.0.0/16"
}

variable "vpn_port_22_security_group_id" {
  description = ""
}

variable "db_port" {
  description = "RDS Postgresql Port"
  default = 5432
}

variable "db_instance_class" {
  description = ""
}

variable "master_user" {
  description = "RDS Master User Name"
}

variable "master_password" {
  description = "RDS Master Password "
}

# variable "alb_account_id" {
#   description = "Alb account ID wrt. aws regions"
# }


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


variable "peer_vpc_id" {
  description = "VPC ID of the Peer Account"
}

variable "peer_cidr" {
  description = "VPC CIDR Block of Peer Account"
}

/*variable "accepter_intra_subnet_name" {
  description = "Subnet name of Peer VPC"
  
}*/

variable "domain_name" {
  description = "Domain Name to be mapped"
}

variable "ami_id" {}

variable "aws_profile" {
  
}