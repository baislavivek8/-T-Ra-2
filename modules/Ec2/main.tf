resource "aws_instance" "Application_server" {
  ami           = "${var.ami_id}"
  instance_type = "t3a.small"
  count         = var.instance_count
  user_data     = "${file("./modules/backend/scripts/hello.sh")}"
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-server"
    "Environment" = var.environment
  }
}

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
