# security.tf

# ALB Security Group: Edit to restrict access to the application

/*data "aws_security_group" "allow-vpn_port_22" {
  id = "${var.vpn_port_22_security_group_id}"
}*/

resource "aws_security_group" "private_vpn_sg" {
  name        = "allow_ssh_vpn"
  description = "Allow SSH inbound traffic from VPN"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description      = "SSH from VPN"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.160.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.environment}-vpn-SG"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "allow_internet_traffic"
  description = "Allow HTTP & HTTPS inbound traffic from Internet"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description      = "HTTP from Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS from Internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.environment}-alb-SG"
    Environment = "${var.environment}"
  }
}


resource "aws_security_group" "private_sg" {
  name = "${var.client_name}-${var.environment}-private-sg"
  description = "allow inbound access from the RDS only"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol = "tcp"
    from_port = 3000
    to_port = 9000
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    protocol = "tcp"
    from_port = 10050
    to_port = 10051
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    protocol = "tcp"
    from_port = 27017
    to_port = 27017
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.environment}-private-SG"
    Environment = "${var.environment}"
  }
}
