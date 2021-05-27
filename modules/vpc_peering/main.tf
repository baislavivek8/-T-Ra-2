provider "aws" {
}

provider "aws" {
  alias = "peer"
}

data "aws_region" "peer" {
  provider = "aws.peer"
}

data "aws_vpc" "peer" {
  provider = "aws.peer"
  id       = "${var.peer_vpc_id}"
}

### accepter route table
data "aws_route_table" "accepter_rtb" {
  provider = aws.peer
  vpc_id   = var.peer_vpc_id
  filter {
    name   = "tag:Name"
    values = [var.accepter_intra_subnet_name]
  }
}

### Requester's side of the connection.
resource "aws_vpc_peering_connection" "requester_connection" {
  provider      = aws.current
  vpc_id        = var.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = var.peer_owner_id
  peer_region   = var.peer_region
  auto_accept   = false
  tags = {
    Side = "Requester"
  }
}

### Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "accepter_connection" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_connection.id
  auto_accept               = true
  tags = {
    Side = "Accepter"
  }
}


### Requester route
resource "aws_route" "requester_route" {
  route_table_id            = var.route_table_id
  destination_cidr_block    = var.accepter_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_connection.id
}


### Accepter route
resource "aws_route" "accepter_route" {
  provider                  = aws.peer
  route_table_id            = data.aws_route_table.accepter_rtb.route_table_id
  destination_cidr_block    = var.requester_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_connection.id
}