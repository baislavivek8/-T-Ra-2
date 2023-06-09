# network.tf

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.client_name}-${var.environment}-vpc"
    Environment = var.environment
  }
}

# Create var.az_count private subnets, each in a different region
resource "aws_subnet" "private" {
  count = var.az_count
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.client_name}-${var.environment}-private-subnet-${data.aws_availability_zones.available.names[count.index]}"
    Environment = var.environment
  }
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count = var.az_count
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.client_name}-${var.environment}-public-subnet-${data.aws_availability_zones.available.names[count.index]}"
    Environment = var.environment
  }
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.client_name}-${var.environment}-igw"
    Environment = var.environment
  }
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id

}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "gw" {
  count = var.az_count
  vpc = true
  depends_on = [
    "aws_internet_gateway.gw"]

  tags = {
    Name = "${var.client_name}-${var.environment}-nat-IP"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "gw" {
  count = var.az_count
  subnet_id = aws_subnet.public.*.id[count.index]
  allocation_id = aws_eip.gw.*.id[count.index]

  tags = {
    Name = "${var.client_name}-${var.environment}-nat-${data.aws_availability_zones.available.names[count.index]}"
    Environment = var.environment
  }
}

# Create a new route table for the private subnets, make it route traffic through the NAT gateway
resource "aws_route_table" "private" {
  count = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }

  tags = {
    Name = "${var.client_name}-${var.environment}-private-route-${data.aws_availability_zones.available.names[count.index]}"
    Environment = var.environment
  }
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count = var.az_count
  subnet_id = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.*.id[count.index]
}
