data "aws_caller_identity" "peer" {
  provider = aws.dst
}

provider "aws" {
  alias = "dst"
}

### Create Accepter route table
# data "aws_route_table" "accepter_rtb" {
#   provider = aws.dst
#   vpc_id   = "vpc-0f2123bb78313ae45"
#   filter {
#     name   = "tag:Name"
#     values = [var.accepter_intra_subnet_name]
#   }
# }

### Requester's side of the connection.
resource "aws_vpc_peering_connection" "requester_connection" {
  vpc_id        = var.vpc_id
  peer_vpc_id   = "vpc-0f2123bb78313ae45"
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = var.aws_peer_region
  auto_accept   = false
  tags = {
    Side = "Requester"
    Name = "${var.client_name}-${var.environment}-requester"
  }
}

### Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "accepter_connection" {
  provider                  = aws.dst
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_connection.id
  auto_accept               = true
  tags = {
    Side = "Accepter"
    Name = "${var.client_name}-${var.environment}-accepter"
  }
}


### Requester route
resource "aws_route" "requester_route" {
  count                     = "${length(var.route_table_id)}"
  route_table_id            = var.route_table_id[count.index]
  destination_cidr_block    = "10.160.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_connection.id
}


### Accepter route
resource "aws_route" "accepter_route" {
  provider                  = aws.dst
  route_table_id            = "rtb-040b20eedc25ec0a1"
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_connection.id
}