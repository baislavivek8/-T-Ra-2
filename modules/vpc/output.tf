#output.tf

output "vpc_id" {
  value = aws_vpc.main.id
}

output "aws_public_subnet" {
  value = aws_subnet.public.*.id
}

output "aws_private_subnet" {
  value = aws_subnet.private.*.id
}

output "aws_natgateway_ips" {
  value = aws_nat_gateway.gw.*.public_ip
}

output "private_route_tables" {
  value = aws_route_table.private.*.id
}
