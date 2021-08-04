resource "aws_instance" "monitoring" {
  ami           = "ami-01f940be8f9e88b75"
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
  ami           = "ami-01b27499734b93d20"
  instance_type = "t3a.large"
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
  ami           = "ami-01b27499734b93d20"
  instance_type = "t3a.medium"
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
  ami           = "ami-05df98f49a3d2a570"
  instance_type = "t3a.small"
  #user_data     = file("${path.module}/scripts/redis_mongo.sh")
  disable_api_termination = false
  
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private_vpn_sg.id, aws_security_group.private_sg.id]
  subnet_id = var.aws_private_subnet[0]
  
  tags = {
    "Name" = "${var.client_name}-${var.environment}-redis-mongo"
    "Environment" = var.environment
    "Backup"  = "yes"
  }

}

  resource "aws_instance" "weaver_db" {
  ami           = "ami-0fbb8601653d82cd3"
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
  ami           = "ami-0fc0b25a90d04cf2e"
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
  ami           = "ami-06cdbac68da07002c"
  instance_type = "t3a.medium"
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
  ami           = "ami-0dfc08b0877522a1a"
  instance_type = "t3a.medium"
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
  ami           = "ami-016577dfcd92bfb52"
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