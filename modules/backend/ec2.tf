resource "aws_instance" "monitoring" {
  ami           = "ami-098d05eed5fbf51b5"
  instance_type = "t3a.small"
  #user_data     = file("${path.module}/scripts/monitoring.sh")
  disable_api_termination = false
  
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_public_subnet[0]
  tags = {
    "Name" = "${var.client_name}-${var.environment}-monitoring"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

resource "aws_instance" "rms_ola" {
  ami           = "ami-0d96c12b2ee9585d0"
  instance_type = "t3a.medium"
  #user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-rms-ola"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "pam_backend" {
  ami           = "ami-0422758e5cacfce51"
  instance_type = "t3a.medium"
  #user_data     = file("${path.module}/scripts/pam_backend.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-backend"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "pam_frontend" {
  ami           = "ami-00b663b5f3c31ee61"
  instance_type = "t3a.small"
  #user_data     = file("${path.module}/scripts/pam_frontend.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-frontend"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "redis_mongo" {
  ami           = "ami-0b7e3cacf3e96c6f8"
  instance_type = "t3a.small"
  #user_data     = file("${path.module}/scripts/redis_mongo.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-redis-two"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "weaver_db" {
  ami           = "ami-06ed5ee141d383818"
  instance_type = "t3a.small"
  #user_data     = file("${path.module}/scripts/weaver_db.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-weaver-db"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "weaver_api_doc" {
  ami           = "ami-08c768b7f27d9786e"
  instance_type = "t3a.medium"
  #user_data     = file("${path.module}/scripts/weaver_api.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-weaver-api-doc"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "sle" {
  ami           = "${var.ami_id}"
  instance_type = "t3a.medium"
  #user_data     = file("${path.module}/scripts/pam_backend.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-sle"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "ige" {
  ami           = "ami-074183e7dcfdd329d"
  instance_type = "t3a.small"
  #user_data     = file("${path.module}/scripts/pam_backend.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-ige"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "dms_dge" {
  ami           = "ami-03637f2f09c3a7c75"
  instance_type = "t3a.medium"
  #user_data     = file("${path.module}/scripts/pam_backend.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-DMS/DGE"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "web_game" {
  ami           = "ami-02fbf64d19ae690d0"
  instance_type = "t3a.large"
  #user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-web-game"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "sbs_vs_trx" {
  ami           = "${var.ami_id}"
  instance_type = "t3a.medium"
  #user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-sbs-vs-trx"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "sbs_front" {
  ami           = "${var.ami_id}"
  instance_type = "t3a.medium"
  #user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-sbs-front"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "portal_web" {
  ami           = "ami-098d05eed5fbf51b5"
  instance_type = "t3a.medium"
  ##user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-portal-web"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "redis" {
  ami           = "ami-06a3c3a81923a9d66"
  instance_type = "t3a.medium"
  ##user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-redis-one"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "dgw_db" {
  ami           = "ami-0fbb8601653d82cd3"
  instance_type = "t3a.medium"
  ##user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-dgw-mysql5.1"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "mongo" {
  ami           = "ami-070b85ab16a18c27e"
  instance_type = "t3a.medium"
  ##user_data     = file("${path.module}/scripts/rms_ola.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-mongo"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}