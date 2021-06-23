#!/bin/bash

BOLD='\033[1m'
CYAN='\033[1;36m'

echo -e "${CYAN}${BOLD}Please select the action you want to take ! Choose from the options below: \n\n1. DEPLOY \n2. DESTROY \n"
read -p "Environment :" action
echo -e "${CYAN}${BOLD}Please select the environment you want to deploy !\n\n1. UAT \n2. PROD\n"
read -p "Environment :" env
echo -e "${CYAN}${BOLD}Please provide the absolute path of the Terraform Variables file\n"
read -p "Terraform Variables File Path :" path
echo -e "${CYAN}${BOLD}Please select the modules you want to deploy\n\n1. RMS-OLA \n2. PAM \n3. WEAVER \n4. ALL\n"
read -p "Module(s) Name :" module_name

if [[ $action == "DEPLOY" ]] 
        if [[ $env == "UAT" ]]
        then
             cd /tmp ; git clone -b uat git@gitlab.com:harshit.wadhawan/terraform.git
             cd terraform ; terraform init
                
              if [[ $module_name == "PAM" ]]
              then
                terraform apply \--var-file=$path \--target module.vpc \--target module.backend.alb \--target module.backend.db \--target module.backend.security \--target module.backend.acm \--target module.backend.ec2.aws_instance.pam_backend \--target module.backend.ec2.aws_instance.pam_frontend \--target module.backend.ec2.aws_instance.redis_mongo \--target module.backend.ec2.aws_instance.monitoring
                exit 0
              elif [[ $env == "RMS-OLA" ]]
              then
                terraform apply \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.rms_ola \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.rms_ola_api_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola_api \--target module.backend.aws_lb_listener_rule.rms_ola_api \--target module.backend.aws_lb_target_group.rms_root_tg \--target module.backend.aws_lb_target_group_attachment.rms_root \--target module.backend.aws_lb_listener_rule.rms_root \--target module.backend.aws_lb_target_group.rms_ola_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola \--target module.backend.aws_lb_listener_rule.rms_ola \--target module.backend.aws_lb_target_group.rms_tg \--target module.backend.aws_lb_target_group_attachment.rms \--target module.backend.aws_lb_listener_rule.rms \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $env == "WEAVER" ]]
              then
                terraform apply \--var-file=$path \--target module.vpc \--target module.backend.alb \--target module.backend.db \--target module.backend.security \--target module.backend.acm \--target module.backend.ec2.aws_instance.weaver_db \--target module.backend.ec2.aws_instance.weaver_api_doc \--target module.backend.ec2.aws_instance.redis_mongo \--target module.backend.ec2.aws_instance.monitoring
                exit 0
              elif [[ $env == "ALL" ]]
              then
                terraform apply \--var-file=$path
                exit 0
              else
                exit 1
              fi

        elif [[ $env == "PROD" ]]
        then
                cd /tmp ; git clone -b prod git@gitlab.com:harshit.wadhawan/terraform.git
                cd terraform ; terraform init 
              
              if [[ $module_name == "PAM" ]]
              then
                terraform apply \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.pam_backend \--target module.backend.aws_instance.pam_frontend \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.pam_tg \--target module.backend.aws_lb_target_group_attachment.pam \--target module.backend.aws_lb_listener_rule.pam \--target module.backend.aws_lb_target_group.pam_api_tg \--target module.backend.aws_lb_target_group_attachment.pam_api \--target module.backend.aws_lb_listener_rule.pam_api \--target module.backend.aws_lb_target_group.pam_api_comm_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_comm \--target module.backend.aws_lb_listener_rule.pam_api_comm \--target module.backend.aws_lb_target_group.pam_api_report_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_report \--target module.backend.aws_lb_listener_rule.pam_api_report \--target module.backend.aws_lb_target_group.pam_api_ram_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_ram \--target module.backend.aws_lb_listener_rule.pam_api_ram \--target module.backend.aws_lb_target_group.pam_api_cashier_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_cashier \--target module.backend.aws_lb_listener_rule.pam_api_cashier \--target module.backend.aws_lb_target_group.comm_tg \--target module.backend.aws_lb_target_group_attachment.comm \--target module.backend.aws_lb_listener_rule.comm \--target module.backend.aws_lb_target_group.reporting_tg \--target module.backend.aws_lb_target_group_attachment.reporting \--target module.backend.aws_lb_listener_rule.reporting \--target module.backend.aws_lb_target_group.cashier_tg \--target module.backend.aws_lb_target_group_attachment.cashier \--target module.backend.aws_lb_listener_rule.cashier \--target module.backend.aws_lb_target_group.ram_tg \--target module.backend.aws_lb_target_group_attachment.ram \--target module.backend.aws_lb_listener_rule.ram \--target module.backend.aws_lb_target_group.pam_backend_tg \--target module.backend.aws_lb_target_group_attachment.pam_backend \--target module.backend.aws_lb_listener_rule.pam_backend \--target module.backend.aws_lb_target_group.comm_backend_tg \--target module.backend.aws_lb_target_group_attachment.comm_backend \--target module.backend.aws_lb_listener_rule.comm_backend \--target module.backend.aws_lb_target_group.reporting_backend_tg \--target module.backend.aws_lb_target_group_attachment.reporting_backend \--target module.backend.aws_lb_listener_rule.reporting_backend \--target module.backend.aws_lb_target_group.ram_backend_tg \--target module.backend.aws_lb_target_group_attachment.ram_backend \--target module.backend.aws_lb_listener_rule.ram_backend \--target module.backend.aws_lb_target_group.cashier_backend_tg \--target module.backend.aws_lb_target_group_attachment.cashier_backend \--target module.backend.aws_lb_listener_rule.cashier_backend \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $module_name == "RMS-OLA" ]]
              then
                terraform apply \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.rms_ola \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.rms_ola_api_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola_api \--target module.backend.aws_lb_listener_rule.rms_ola_api \--target module.backend.aws_lb_target_group.rms_root_tg \--target module.backend.aws_lb_target_group_attachment.rms_root \--target module.backend.aws_lb_listener_rule.rms_root \--target module.backend.aws_lb_target_group.rms_ola_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola \--target module.backend.aws_lb_listener_rule.rms_ola \--target module.backend.aws_lb_target_group.rms_tg \--target module.backend.aws_lb_target_group_attachment.rms \--target module.backend.aws_lb_listener_rule.rms \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $module_name == "WEAVER" ]]
              then
                terraform apply \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.weaver_db \--target module.backend.aws_instance.weaver_api_doc  \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.weaver_tg \--target module.backend.aws_lb_target_group_attachment.weaver \--target module.backend.aws_lb_listener_rule.weaver \--target module.backend.aws_lb_target_group.weaver_bo_tg \--target module.backend.aws_lb_target_group_attachment.weaver_bo \--target module.backend.aws_lb_listener_rule.weaver_bo \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $module_name == "ALL" ]]
              then
                terraform apply \--var-file=$path
                exit 0
              else
                exit 1
              fi
                
        else
                        exit 1
        fi

elif [[ $action == "DESTROY" ]] 
        if [[ $env == "UAT" ]]
        then
             cd /tmp ; git clone -b uat git@gitlab.com:harshit.wadhawan/terraform.git
             cd terraform ; terraform init
                
              if [[ $module_name == "PAM" ]]
              then
                terraform destroy \--var-file=$path \--target module.vpc \--target module.backend.alb \--target module.backend.db \--target module.backend.security \--target module.backend.acm \--target module.backend.ec2.aws_instance.pam_backend \--target module.backend.ec2.aws_instance.pam_frontend \--target module.backend.ec2.aws_instance.redis_mongo \--target module.backend.ec2.aws_instance.monitoring
                exit 0
              elif [[ $env == "RMS-OLA" ]]
              then
                terraform destroy \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.rms_ola \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.rms_ola_api_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola_api \--target module.backend.aws_lb_listener_rule.rms_ola_api \--target module.backend.aws_lb_target_group.rms_root_tg \--target module.backend.aws_lb_target_group_attachment.rms_root \--target module.backend.aws_lb_listener_rule.rms_root \--target module.backend.aws_lb_target_group.rms_ola_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola \--target module.backend.aws_lb_listener_rule.rms_ola \--target module.backend.aws_lb_target_group.rms_tg \--target module.backend.aws_lb_target_group_attachment.rms \--target module.backend.aws_lb_listener_rule.rms \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $env == "WEAVER" ]]
              then
                terraform destroy \--var-file=$path \--target module.vpc \--target module.backend.alb \--target module.backend.db \--target module.backend.security \--target module.backend.acm \--target module.backend.ec2.aws_instance.weaver_db \--target module.backend.ec2.aws_instance.weaver_api_doc \--target module.backend.ec2.aws_instance.redis_mongo \--target module.backend.ec2.aws_instance.monitoring
                exit 0
              elif [[ $env == "ALL" ]]
              then
                terraform apply \--var-file=$path
                exit 0
              else
                exit 1
              fi

        elif [[ $env == "PROD" ]]
        then
                cd /tmp ; git clone -b prod git@gitlab.com:harshit.wadhawan/terraform.git
                cd terraform ; terraform init 
              
              if [[ $module_name == "PAM" ]]
              then
                terraform destroy \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.pam_backend \--target module.backend.aws_instance.pam_frontend \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.pam_tg \--target module.backend.aws_lb_target_group_attachment.pam \--target module.backend.aws_lb_listener_rule.pam \--target module.backend.aws_lb_target_group.pam_api_tg \--target module.backend.aws_lb_target_group_attachment.pam_api \--target module.backend.aws_lb_listener_rule.pam_api \--target module.backend.aws_lb_target_group.pam_api_comm_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_comm \--target module.backend.aws_lb_listener_rule.pam_api_comm \--target module.backend.aws_lb_target_group.pam_api_report_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_report \--target module.backend.aws_lb_listener_rule.pam_api_report \--target module.backend.aws_lb_target_group.pam_api_ram_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_ram \--target module.backend.aws_lb_listener_rule.pam_api_ram \--target module.backend.aws_lb_target_group.pam_api_cashier_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_cashier \--target module.backend.aws_lb_listener_rule.pam_api_cashier \--target module.backend.aws_lb_target_group.comm_tg \--target module.backend.aws_lb_target_group_attachment.comm \--target module.backend.aws_lb_listener_rule.comm \--target module.backend.aws_lb_target_group.reporting_tg \--target module.backend.aws_lb_target_group_attachment.reporting \--target module.backend.aws_lb_listener_rule.reporting \--target module.backend.aws_lb_target_group.cashier_tg \--target module.backend.aws_lb_target_group_attachment.cashier \--target module.backend.aws_lb_listener_rule.cashier \--target module.backend.aws_lb_target_group.ram_tg \--target module.backend.aws_lb_target_group_attachment.ram \--target module.backend.aws_lb_listener_rule.ram \--target module.backend.aws_lb_target_group.pam_backend_tg \--target module.backend.aws_lb_target_group_attachment.pam_backend \--target module.backend.aws_lb_listener_rule.pam_backend \--target module.backend.aws_lb_target_group.comm_backend_tg \--target module.backend.aws_lb_target_group_attachment.comm_backend \--target module.backend.aws_lb_listener_rule.comm_backend \--target module.backend.aws_lb_target_group.reporting_backend_tg \--target module.backend.aws_lb_target_group_attachment.reporting_backend \--target module.backend.aws_lb_listener_rule.reporting_backend \--target module.backend.aws_lb_target_group.ram_backend_tg \--target module.backend.aws_lb_target_group_attachment.ram_backend \--target module.backend.aws_lb_listener_rule.ram_backend \--target module.backend.aws_lb_target_group.cashier_backend_tg \--target module.backend.aws_lb_target_group_attachment.cashier_backend \--target module.backend.aws_lb_listener_rule.cashier_backend \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $module_name == "RMS-OLA" ]]
              then
                terraform destroy \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.rms_ola \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.rms_ola_api_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola_api \--target module.backend.aws_lb_listener_rule.rms_ola_api \--target module.backend.aws_lb_target_group.rms_root_tg \--target module.backend.aws_lb_target_group_attachment.rms_root \--target module.backend.aws_lb_listener_rule.rms_root \--target module.backend.aws_lb_target_group.rms_ola_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola \--target module.backend.aws_lb_listener_rule.rms_ola \--target module.backend.aws_lb_target_group.rms_tg \--target module.backend.aws_lb_target_group_attachment.rms \--target module.backend.aws_lb_listener_rule.rms \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $module_name == "WEAVER" ]]
              then
                terraform destroy \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.weaver_db \--target module.backend.aws_instance.weaver_api_doc  \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.weaver_tg \--target module.backend.aws_lb_target_group_attachment.weaver \--target module.backend.aws_lb_listener_rule.weaver \--target module.backend.aws_lb_target_group.weaver_bo_tg \--target module.backend.aws_lb_target_group_attachment.weaver_bo \--target module.backend.aws_lb_listener_rule.weaver_bo \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance
                exit 0
              elif [[ $module_name == "ALL" ]]
              then
                terraform destroy \--var-file=$path
                exit 0
              else
                exit 1
              fi
                
        else
                        exit 1
        fi
fi