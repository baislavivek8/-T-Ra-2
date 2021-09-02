variable "vpc_id" {}

variable "vpc_cidr" {}

variable "route_table_id" {}

#variable "peer_vpc_id" {}

#variable "peer_owner_id" {}

#variable "peer_region" {}

#variable "accepter_cidr_block" {}

#variable "route_table_id" {}

#variable "requester_cidr_block" {}

#variable "accepter_intra_subnet_name" {}

variable "aws_peer_region" {
    description = "Region of the Peer Account"
}

#variable "aws_region" {}

variable "environment" {
  description = "The name of the environment"
}

variable "client_name" {
  description = "Name of the project being built"
  default = "default"
}