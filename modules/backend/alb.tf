# alb.tf

#Application Load Balancer
resource "aws_alb" "alb" {
  load_balancer_type = "application"
  name = "${var.client_name}-${var.environment}-alb"
  subnets = var.aws_public_subnet
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    "Name" = "${var.client_name}-${var.environment}-alb"
    "Environment" = var.environment
  }
}
############################################### ROUTE 1 ###########################################################################
# Target Group Creation RMS OLA API
resource "aws_lb_target_group" "rms_ola_api_tg" {
  name = "${var.client_name}-${var.environment}-rms-ola-api-TG"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-rms-ola-api-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA API
resource "aws_lb_target_group_attachment" "rms_ola_api" {
  target_group_arn = aws_lb_target_group.rms_ola_api_tg.arn
  target_id        = aws_instance.rms_ola.id
  port             = 3000
}

# Route RMS OLA API
resource "aws_lb_listener_rule" "rms_ola_api" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rms_ola_api_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api"]
    }
  }

  condition {
    host_header {
      values = ["backoffice.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 2 ###########################################################################
# Target Group Creation RMS OLA
resource "aws_lb_target_group" "rms_root_tg" {
  name = "${var.client_name}-${var.environment}-rms-root-TG"
  port = 4300
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-rms-root-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "rms_root" {
  target_group_arn = aws_lb_target_group.rms_root_tg.arn
  target_id        = aws_instance.rms_ola.id
  port             = 4300
}

# Route RMS OLA
resource "aws_lb_listener_rule" "rms_root" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rms_root_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["rms.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 3 ###########################################################################
# ALB Target Group Creation RMS OLA

resource "aws_lb_target_group" "rms_ola_tg" {
  name = "${var.client_name}-${var.environment}-rms-ola-TG"
  port = 8083
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/OLA"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-rms-ola-TG"
    "Environment" = var.environment
  }
}

#Target Group Attachment RMS OLA
resource "aws_lb_target_group_attachment" "rms_ola" {
  target_group_arn = aws_lb_target_group.rms_ola_tg.arn
  target_id        = aws_instance.rms_ola.id
  port             = 8083
}

# ALB Route RMS OLA
resource "aws_lb_listener_rule" "rms_ola" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rms_ola_tg.arn
  }

  condition {
    path_pattern {
      values = ["/OLA"]
    }
  }

  condition {
    host_header {
      values = ["rms.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 4 ###########################################################################
# Target Group Creation RMS OLA
resource "aws_lb_target_group" "rms_tg" {
  name = "${var.client_name}-${var.environment}-rms-TG"
  port = 8082
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/RMS"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-rms-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "rms" {
  target_group_arn = aws_lb_target_group.rms_tg.arn
  target_id        = aws_instance.rms_ola.id
  port             = 8082
}

# Route RMS OLA
resource "aws_lb_listener_rule" "rms" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rms_tg.arn
  }

  condition {
    path_pattern {
      values = ["/RMS"]
    }
  }

  condition {
    host_header {
      values = ["rms.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 5 ###########################################################################
# Target Group Creation WEAVER
resource "aws_lb_target_group" "weaver_tg" {
  name = "${var.client_name}-${var.environment}-weaver-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/Weaver"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-weaver-TG"
    "Environment" = var.environment
  }
}

#TG Attachment WEAVER
resource "aws_lb_target_group_attachment" "weaver" {
  target_group_arn = aws_lb_target_group.weaver_tg.arn
  target_id        = aws_instance.weaver_api_doc.id
  port             = 8080
}

# Route RMS WEAVER
resource "aws_lb_listener_rule" "weaver" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.weaver_tg.arn
  }

  condition {
    path_pattern {
      values = ["/Weaver/","/WeaverDoc"]
    }
  }

  condition {
    host_header {
      values = ["api.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 6 ###########################################################################
# Target Group Creation RMS OLA
resource "aws_lb_target_group" "weaver_bo_tg" {
  name = "${var.client_name}-${var.environment}-weaver-BO-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/Weaver"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-weaver-BO-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "weaver_bo" {
  target_group_arn = aws_lb_target_group.weaver_bo_tg.arn
  target_id        = aws_instance.weaver_api_doc.id
  port             = 8080
}

# Route RMS OLA
resource "aws_lb_listener_rule" "weaver_bo" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.weaver_bo_tg.arn
  }

  condition {
    path_pattern {
      values = ["/WeaverBo","/IGEBackOffice"]
    }
  }

  condition {
    host_header {
      values = ["bo.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 7 ###########################################################################
# Target Group Creation PAM
resource "aws_lb_target_group" "pam_tg" {
  name = "${var.client_name}-${var.environment}-pam-TG"
  port = 4300
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam" {
  target_group_arn = aws_lb_target_group.pam_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 4300
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["pam.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 8 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "pam_api_tg" {
  name = "${var.client_name}-${var.environment}-pam-api-TG"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/api/PAM"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-api-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam_api" {
  target_group_arn = aws_lb_target_group.pam_api_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 3000
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam_api" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_api_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/PAM"]
    }
  }

  condition {
    host_header {
      values = ["pam.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 9 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "pam_api_comm_tg" {
  name = "${var.client_name}-${var.environment}-pam-api-comm-TG"
  port = 3003
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/api/COMM"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-api-comm-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam_api_comm" {
  target_group_arn = aws_lb_target_group.pam_api_comm_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 3003
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam_api_comm" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_api_comm_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/COMM"]
    }
  }

  condition {
    host_header {
      values = ["pam.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 10 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "pam_api_report_tg" {
  name = "${var.client_name}-${var.environment}-pam-api-report-TG"
  port = 3004
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/api/REPORTING"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-api-report-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam_api_report" {
  target_group_arn = aws_lb_target_group.pam_api_report_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 3004
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam_api_report" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_api_report_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/REPORTING"]
    }
  }

  condition {
    host_header {
      values = ["pam.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 11 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "pam_api_ram_tg" {
  name = "${var.client_name}-${var.environment}-pam-api-ram-TG"
  port = 3005
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/api/RAM"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-api-ram-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam_api_ram" {
  target_group_arn = aws_lb_target_group.pam_api_ram_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 3005
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam_api_ram" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_api_ram_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/RAM"]
    }
  }

  condition {
    host_header {
      values = ["pam.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 12 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "pam_api_cashier_tg" {
  name = "${var.client_name}-${var.environment}-pam-api-csher-TG"
  port = 3006
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/api/CASHIER"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-api-csher-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam_api_cashier" {
  target_group_arn = aws_lb_target_group.pam_api_cashier_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 3006
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam_api_cashier" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_api_cashier_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/CASHIER"]
    }
  }

  condition {
    host_header {
      values = ["pam.${var.domain_name}"]
    }
  }
}

############################################### ROUTE  ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "pam_api_rg_tg" {
  name = "${var.client_name}-${var.environment}-pam-api-rg-TG"
  port = 3002
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/api/RG"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-api-rg-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam_api_rg" {
  target_group_arn = aws_lb_target_group.pam_api_rg_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 3002
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam_api_rg" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_api_rg_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/RG"]
    }
  }

  condition {
    host_header {
      values = ["pam.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 13 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "comm_tg" {
  name = "${var.client_name}-${var.environment}-comm-TG"
  port = 4303
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-comm-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "comm" {
  target_group_arn = aws_lb_target_group.comm_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 4303
}

# Route RMS OLA
resource "aws_lb_listener_rule" "comm" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.comm_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["comm.${var.domain_name}"]
    }
  }
}



############################################### ROUTE 14 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "reporting_tg" {
  name = "${var.client_name}-${var.environment}-reporting-TG"
  port = 4304
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-reporting-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "reporting" {
  target_group_arn = aws_lb_target_group.reporting_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 4304
}

# Route RMS OLA
resource "aws_lb_listener_rule" "reporting" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.reporting_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["reporting.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 15 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "cashier_tg" {
  name = "${var.client_name}-${var.environment}-cashier-TG"
  port = 4306
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-cashier-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "cashier" {
  target_group_arn = aws_lb_target_group.cashier_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 4306
}

# Route RMS OLA
resource "aws_lb_listener_rule" "cashier" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cashier_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["cashier.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 16 ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "ram_tg" {
  name = "${var.client_name}-${var.environment}-ram-TG"
  port = 4305
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-ram-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "ram" {
  target_group_arn = aws_lb_target_group.ram_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 4305
}

# Route RMS OLA
resource "aws_lb_listener_rule" "ram" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ram_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["ram.${var.domain_name}"]
    }
  }
}

############################################### ROUTE  ###########################################################################
# Target Group Creation PAM API
resource "aws_lb_target_group" "rg_tg" {
  name = "${var.client_name}-${var.environment}-rg-TG"
  port = 4302
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-rg-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "rg" {
  target_group_arn = aws_lb_target_group.rg_tg.arn
  target_id        = aws_instance.pam_frontend.id
  port             = 4302
}

# Route RMS OLA
resource "aws_lb_listener_rule" "rg" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rg_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["rg.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 17 ###########################################################################
# Target Group Creation PAM
resource "aws_lb_target_group" "pam_backend_tg" {
  name = "${var.client_name}-${var.environment}-pam-backend-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-pam-backend-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "pam_backend" {
  target_group_arn = aws_lb_target_group.pam_backend_tg.arn
  target_id        = aws_instance.pam_backend.id
  port             = 8080
}

# Route RMS OLA
resource "aws_lb_listener_rule" "pam_backend" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pam_backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["pam-backend.${var.domain_name}"]
    }
  }
}



############################################### ROUTE 18 ###########################################################################
# Target Group Creation PAM
resource "aws_lb_target_group" "comm_backend_tg" {
  name = "${var.client_name}-${var.environment}-comm-backend-TG"
  port = 8081
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-comm-backend-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "comm_backend" {
  target_group_arn = aws_lb_target_group.comm_backend_tg.arn
  target_id        = aws_instance.pam_backend.id
  port             = 8081
}

# Route RMS OLA
resource "aws_lb_listener_rule" "comm_backend" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.comm_backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["comm-backend.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 19 ###########################################################################
# Target Group Creation PAM
resource "aws_lb_target_group" "reporting_backend_tg" {
  name = "${var.client_name}-${var.environment}-reporting-bkd-TG"
  port = 8083
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-reporting-bkd-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "reporting_backend" {
  target_group_arn = aws_lb_target_group.reporting_backend_tg.arn
  target_id        = aws_instance.pam_backend.id
  port             = 8081
}

# Route RMS OLA
resource "aws_lb_listener_rule" "reporting_backend" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.reporting_backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["reporting-backend.${var.domain_name}"]
    }
  }
}



############################################### ROUTE 20 ###########################################################################
# Target Group Creation PAM
resource "aws_lb_target_group" "ram_backend_tg" {
  name = "${var.client_name}-${var.environment}-ram-backend-TG"
  port = 8084
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-ram-backend-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "ram_backend" {
  target_group_arn = aws_lb_target_group.ram_backend_tg.arn
  target_id        = aws_instance.pam_backend.id
  port             = 8084
}

# Route RMS OLA
resource "aws_lb_listener_rule" "ram_backend" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ram_backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["ram-backend.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 21 ###########################################################################
# Target Group Creation PAM
resource "aws_lb_target_group" "cashier_backend_tg" {
  name = "${var.client_name}-${var.environment}-cashier-bcknd-TG"
  port = 8085
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-cashier-bcknd-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "cashier_backend" {
  target_group_arn = aws_lb_target_group.cashier_backend_tg.arn
  target_id        = aws_instance.pam_backend.id
  port             = 8085
}

# Route RMS OLA
resource "aws_lb_listener_rule" "cashier_backend" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cashier_backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["cashier-backend.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 22 ###########################################################################
# Target Group Creation SLE
resource "aws_lb_target_group" "sle_tg" {
  name = "${var.client_name}-${var.environment}-sle-TG"
  port = 8082
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-sle-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "sle" {
  target_group_arn = aws_lb_target_group.sle_tg.arn
  target_id        = aws_instance.sle.id
  port             = 8082
}

# Route RMS OLA
resource "aws_lb_listener_rule" "sle" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sle_tg.arn
  }

  condition {
    path_pattern {
      values = ["/SportsLottery","/DrawMachine"]
    }
  }

  condition {
    host_header {
      values = ["sle.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 23 ###########################################################################
# Target Group Creation SLE
resource "aws_lb_target_group" "sle2_tg" {
  name = "${var.client_name}-${var.environment}-sle2-TG"
  port = 8001
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-sle2-TG"
    "Environment" = var.environment
  }
}

#TG Attachment RMS OLA
resource "aws_lb_target_group_attachment" "sle2" {
  target_group_arn = aws_lb_target_group.sle2_tg.arn
  target_id        = aws_instance.sle.id
  port             = 8001
}

# Route RMS OLA
resource "aws_lb_listener_rule" "sle2" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sle2_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["sle.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 24 ###########################################################################
# Target Group Creation IGE
resource "aws_lb_target_group" "ige_tg" {
  name = "${var.client_name}-${var.environment}-ige-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-ige-TG"
    "Environment" = var.environment
  }
}

#TG Attachment IGE
resource "aws_lb_target_group_attachment" "ige" {
  target_group_arn = aws_lb_target_group.ige_tg.arn
  target_id        = aws_instance.ige.id
  port             = 8080
}

# Route IGE
resource "aws_lb_listener_rule" "ige" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ige_tg.arn
  }

  condition {
    path_pattern {
      values = ["/InstantGameEngine","/IGEContent","/InstantGameEngineMS"]
    }
  }

  condition {
    host_header {
      values = ["ige.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 25 ###########################################################################
# Target Group Creation DMS
resource "aws_lb_target_group" "dms_tg" {
  name = "${var.client_name}-${var.environment}-dms-TG"
  port = 8081
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-dms-TG"
    "Environment" = var.environment
  }
}

#TG Attachment DMS
resource "aws_lb_target_group_attachment" "dms" {
  target_group_arn = aws_lb_target_group.dms_tg.arn
  target_id        = aws_instance.dms_dge.id
  port             = 8081
}

# Route IGE
resource "aws_lb_listener_rule" "dms" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dms_tg.arn
  }

  condition {
    path_pattern {
      values = ["/DMS","/SuperKeno","/LuckySix","/LottoDiamond"]
    }
  }

  condition {
    host_header {
      values = ["dms.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 26 ###########################################################################
# Target Group Creation DMS
resource "aws_lb_target_group" "web_game_tg" {
  name = "${var.client_name}-${var.environment}-web-game-TG"
  port = 4200
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-web-game-TG"
    "Environment" = var.environment
  }
}

#TG Attachment DMS
resource "aws_lb_target_group_attachment" "web_game" {
  target_group_arn = aws_lb_target_group.web_game_tg.arn
  target_id        = aws_instance.web_game.id
  port             = 4200
}

# Route IGE
resource "aws_lb_listener_rule" "web_game" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_game_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["games.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 27 ###########################################################################
# Target Group Creation GAMES
resource "aws_lb_target_group" "web_game_api_tg" {
  name = "${var.client_name}-${var.environment}-web-gm-api-TG"
  port = 3001
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-web-gm-api-TG"
    "Environment" = var.environment
  }
}

#TG Attachment DMS
resource "aws_lb_target_group_attachment" "web_game_api" {
  target_group_arn = aws_lb_target_group.web_game_api_tg.arn
  target_id        = aws_instance.web_game.id
  port             = 3001
}

# Route IGE
resource "aws_lb_listener_rule" "web_game_api" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_game_api_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api","/websocket"]
    }
  }

  condition {
    host_header {
      values = ["games.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 28 ###########################################################################
# Target Group Creation SBS
resource "aws_lb_target_group" "sbs_vs_tg" {
  name = "${var.client_name}-${var.environment}-sbs-vs-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-sbs-vs-TG"
    "Environment" = var.environment
  }
}

#TG Attachment SBS
resource "aws_lb_target_group_attachment" "sbs_vs" {
  target_group_arn = aws_lb_target_group.sbs_vs_tg.arn
  target_id        = aws_instance.sbs_vs_trx.id
  port             = 8080
}

# Route SBS
resource "aws_lb_listener_rule" "sbs_vs" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sbs_vs_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["vs-front.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 29 ###########################################################################
# Target Group Creation SBS
resource "aws_lb_target_group" "sbs_vs_bo_tg" {
  name = "${var.client_name}-${var.environment}-sbs-vs-bo-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-sbs-vs-bo-TG"
    "Environment" = var.environment
  }
}

#TG Attachment SBS
resource "aws_lb_target_group_attachment" "sbs_vs_bo" {
  target_group_arn = aws_lb_target_group.sbs_vs_bo_tg.arn
  target_id        = aws_instance.sbs_vs_trx.id
  port             = 80
}

# Route SBS
resource "aws_lb_listener_rule" "sbs_vs_bo" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sbs_vs_bo_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["vs-bo.${var.domain_name}","vs.${var.domain_name}"]
    }
  }
}

############################################### ROUTE 30 ###########################################################################
# Target Group Creation SBS FRONT
resource "aws_lb_target_group" "sbs_front_tg" {
  name = "${var.client_name}-${var.environment}-sbs-front-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-sbs-front-TG"
    "Environment" = var.environment
  }
}

#TG Attachment SBS
resource "aws_lb_target_group_attachment" "sbs_front" {
  target_group_arn = aws_lb_target_group.sbs_front_tg.arn
  target_id        = aws_instance.sbs_front.id
  port             = 8080
}

# Route SBS
resource "aws_lb_listener_rule" "sbs_front" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sbs_front_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["sbs-front.${var.domain_name}"]
    }
  }
}


############################################### ROUTE 31 ###########################################################################
# Target Group Creation SBS FRONT
resource "aws_lb_target_group" "portal_web_tg" {
  name = "${var.client_name}-${var.environment}-portal-web-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.client_name}-${var.environment}-portal-web-TG"
    "Environment" = var.environment
  }
}

#TG Attachment SBS
resource "aws_lb_target_group_attachment" "portal_web" {
  target_group_arn = aws_lb_target_group.portal_web_tg.arn
  target_id        = aws_instance.portal_web.id
  port             = 80
}

# Route SBS
resource "aws_lb_listener_rule" "portal_web" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.portal_web_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  condition {
    host_header {
      values = ["www.${var.domain_name}"]
    }
  }
}

########################################### ROUTING ENDS #######################################################
# Redirect all traffic from Port 80 to 443
resource "aws_lb_listener" "alb-listener-http" {
  load_balancer_arn = aws_alb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


# Redirect all traffic from the ALB to the target group
resource "aws_lb_listener" "alb-listener-https" {
  load_balancer_arn = aws_alb.alb.id
  port = 443
  protocol = "HTTPS"
  certificate_arn = aws_acm_certificate.cert.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
  depends_on = [aws_acm_certificate.cert]
}

# Mapping ALB DNS to Route53 A record,
# any traffic to DNS will route to ALB

# SSL for ALB
resource "aws_lb_listener_certificate" "alb-cert" {
  listener_arn = aws_lb_listener.alb-listener-https.arn
  certificate_arn = aws_acm_certificate.cert.arn
}
