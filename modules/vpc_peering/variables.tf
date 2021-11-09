variable "vpc_id" {}

variable "vpc_cidr" {}

variable "route_table_id" {}

variable "aws_peer_region" {
    description = "Region of the Peer Account"
}

variable "environment" {
  description = "The name of the environment"
}

variable "client_name" {
  description = "Name of the project being built"
  default = "default"
}
