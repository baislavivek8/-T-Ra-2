#!/bin/bash

BOLD='\033[1m'
CYAN='\033[1;36m'

#### Function Definition for PAM Module #####
pam()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.pam_backend \--target module.backend.aws_instance.pam_frontend \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_lb_target_group.rg_backend_tg \--target module.backend.aws_lb_target_group_attachment.rg_backend \--target module.backend.aws_lb_listener_rule.rg_backend \--target module.backend.aws_lb_target_group.pam_tg \--target module.backend.aws_lb_target_group_attachment.pam \--target module.backend.aws_lb_listener_rule.pam \--target module.backend.aws_lb_target_group.rg_tg \--target module.backend.aws_lb_target_group_attachment.rg \--target module.backend.aws_lb_listener_rule.rg \--target module.backend.aws_lb_target_group.pam_api_tg \--target module.backend.aws_lb_target_group_attachment.pam_api \--target module.backend.aws_lb_listener_rule.pam_api \--target module.backend.aws_lb_target_group.pam_api_comm_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_comm \--target module.backend.aws_lb_listener_rule.pam_api_comm \--target module.backend.aws_lb_target_group.pam_api_report_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_report \--target module.backend.aws_lb_listener_rule.pam_api_report \--target module.backend.aws_lb_target_group.pam_api_ram_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_ram \--target module.backend.aws_lb_listener_rule.pam_api_ram \--target module.backend.aws_lb_target_group.pam_api_cashier_tg \--target module.backend.aws_lb_target_group_attachment.pam_api_cashier \--target module.backend.aws_lb_listener_rule.pam_api_cashier \--target module.backend.aws_lb_target_group.comm_tg \--target module.backend.aws_lb_target_group_attachment.comm \--target module.backend.aws_lb_listener_rule.comm \--target module.backend.aws_lb_target_group.reporting_tg \--target module.backend.aws_lb_target_group_attachment.reporting \--target module.backend.aws_lb_listener_rule.reporting \--target module.backend.aws_lb_target_group.cashier_tg \--target module.backend.aws_lb_target_group_attachment.cashier \--target module.backend.aws_lb_listener_rule.cashier \--target module.backend.aws_lb_target_group.ram_tg \--target module.backend.aws_lb_target_group_attachment.ram \--target module.backend.aws_lb_listener_rule.ram \--target module.backend.aws_lb_target_group.pam_backend_tg \--target module.backend.aws_lb_target_group_attachment.pam_backend \--target module.backend.aws_lb_listener_rule.pam_backend \--target module.backend.aws_lb_target_group.comm_backend_tg \--target module.backend.aws_lb_target_group_attachment.comm_backend \--target module.backend.aws_lb_listener_rule.comm_backend \--target module.backend.aws_lb_target_group.reporting_backend_tg \--target module.backend.aws_lb_target_group_attachment.reporting_backend \--target module.backend.aws_lb_listener_rule.reporting_backend \--target module.backend.aws_lb_target_group.ram_backend_tg \--target module.backend.aws_lb_target_group_attachment.ram_backend \--target module.backend.aws_lb_listener_rule.ram_backend \--target module.backend.aws_lb_target_group.cashier_backend_tg \--target module.backend.aws_lb_target_group_attachment.cashier_backend \--target module.backend.aws_lb_listener_rule.cashier_backend --auto-approve

}

#### Function Definition for RMS-OLA Module #####
rms_ola()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.rms_ola \--target module.backend.aws_lb_target_group.rms_ola_api_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola_api \--target module.backend.aws_lb_listener_rule.rms_ola_api \--target module.backend.aws_lb_target_group.rms_root_tg \--target module.backend.aws_lb_target_group_attachment.rms_root \--target module.backend.aws_lb_listener_rule.rms_root \--target module.backend.aws_lb_target_group.rms_ola_tg \--target module.backend.aws_lb_target_group_attachment.rms_ola \--target module.backend.aws_lb_listener_rule.rms_ola \--target module.backend.aws_lb_target_group.rms_tg \--target module.backend.aws_lb_target_group_attachment.rms \--target module.backend.aws_lb_listener_rule.rms --auto-approve

}

#### Function Definition for WEAVER Module #####
weaver()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.weaver_db \--target module.backend.aws_instance.weaver_api_doc \--target module.backend.aws_lb_target_group.weaver_tg \--target module.backend.aws_lb_target_group_attachment.weaver \--target module.backend.aws_lb_listener_rule.weaver \--target module.backend.aws_lb_target_group.weaver_bo_tg \--target module.backend.aws_lb_target_group_attachment.weaver_bo \--target module.backend.aws_lb_listener_rule.weaver_bo --auto-approve

}

#### Function Definition for SPORTS LOTTERY Module #####
sle()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.sle \--target module.backend.aws_lb_target_group.sle_tg \--target module.backend.aws_lb_target_group_attachment.sle \--target module.backend.aws_lb_listener_rule.sle \--target module.backend.aws_lb_target_group.sle2_tg \--target module.backend.aws_lb_target_group_attachment.sle2 \--target module.backend.aws_lb_listener_rule.sle2 --auto-approve

}

#### Function Definition for DMS Module #####
dms()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.dms \--target module.backend.aws_instance.dgw_db \--target module.backend.aws_lb_target_group.dms_tg \--target module.backend.aws_lb_target_group_attachment.dms \--target module.backend.aws_lb_listener_rule.dms --auto-approve

}

#### Function Definition for IGE Module #####
ige()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.ige \--target module.backend.aws_lb_target_group.ige_tg \--target module.backend.aws_lb_target_group_attachment.ige \--target module.backend.aws_lb_listener_rule.ige --auto-approve

}

portal_web()

{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.portal_web \--target module.backend.aws_lb_target_group.portal_web_tg \--target module.backend.aws_lb_target_group_attachment.portal_web \--target module.backend.aws_lb_listener_rule.portal_web --auto-approve

}

#### Function Definition for WEB-GAME Module #####
web_game()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.web_game \--target module.backend.aws_lb_target_group.web_game_tg \--target module.backend.aws_lb_target_group_attachment.web_game \--target module.backend.aws_lb_listener_rule.web_game \--target module.backend.aws_lb_target_group.web_game_api_tg \--target module.backend.aws_lb_target_group_attachment.web_game_api \--target module.backend.aws_lb_listener_rule.web_game_api --auto-approve

}

#### Function Definition for SBS-VS Module #####
sbs_vs()
{
    terraform apply \--var-file=$path \--target module.backend.aws_instance.sbs_vs_trx \--target module.backend.aws_instance.sbs_front \--target module.backend.aws_lb_target_group.sbs_vs_bo_tg \--target module.backend.aws_lb_target_group_attachment.sbs_vs_bo \--target module.backend.aws_lb_listener_rule.sbs_vs_bo \--target module.backend.aws_lb_target_group.sbs_vs_tg \--target module.backend.aws_lb_target_group_attachment.sbs_vs \--target module.backend.aws_lb_listener_rule.sbs_vs \--target module.backend.aws_lb_target_group.sbs_front_tg \--target module.backend.aws_lb_target_group_attachment.sbs_front \--target module.backend.aws_lb_listener_rule.sbs_front --auto-approve

}
#### Function Definition for DEFAULT Module. Contains VPC, SG, ALB, Certs, Monitoring & Redis-Mongo instances. #####
default()
{
    terraform apply \--var-file=$path \--target module.vpc \--target module.backend.aws_security_group.private_vpn_sg \--target module.backend.aws_security_group.alb_sg \--target module.backend.aws_security_group.private_sg  \--target module.backend.aws_acm_certificate.cert \--target module.backend.aws_instance.redis_mongo \--target module.backend.aws_instance.redis \--target module.backend.aws_instance.mongo \--target module.backend.aws_instance.monitoring \--target module.backend.aws_alb.alb \--target module.backend.aws_iam_role.dlm_lifecycle_role \--target module.backend.aws_iam_role_policy.dlm_lifecycle \--target module.backend.aws_dlm_lifecycle_policy.backup \--target module.backend.aws_lb_listener.alb-listener-http \--target module.backend.aws_lb_listener.alb-listener-https \--target module.backend.aws_lb_listener_certificate.alb-cert --auto-approve

}

#### Function Definition for RDS DATABASE Module #####
db()
{
    terraform apply \--var-file=$path \--target module.backend.aws_db_parameter_group.rds-mysql \--target module.backend.aws_db_subnet_group.db-subnet-group \--target module.backend.aws_db_instance.mysql-instance --auto-approve

}

#### Function Definition for deploying ALL Modules #####
all()
{
    terraform apply \--var-file=$path --auto-approve

}

echo -e "${CYAN}${BOLD}Please select the action you want to take ! Choose from the options below: \n\n1. DEPLOY \n2. DESTROY \n"
read -p "Environment :" action
echo -e "${CYAN}${BOLD}Please select the environment you want to deploy !\n\n1. UAT \n2. PROD\n \n3. ULTRA"
read -p "Environment :" env
echo -e "${CYAN}${BOLD}Please provide the absolute path of the Terraform Variables file\n"
read -p "Terraform Variables File Path :" path
# echo -e "${CYAN}${BOLD}Please choose the modules you want to deploy\n\n1. RMS-OLA \n2. PAM \n3. WEAVER \n4. SPORTS-LOTTERY \n5. IGE \n6. DMS \n7. WEB-GAME \n8. SBS-VS \n8. ALL \n"
# read -p "Module(s) Name :" module_name

if [[ $action == "DEPLOY" ]]
then
        if [[ $env == "UAT" ]]
        then
             cd /tmp ; git clone -b uat git@gitlab.com:harshit.wadhawan/terraform.git
             cd terraform ; terraform init
                echo -e "\n${CYAN}${BOLD}Please choose the modules you want to deploy\n\n1. rms_ola \n2. pam \n3. weaver \n4. sle \n5. ige \n6. dms \n7. web_game \n8. sbs_vs \n8. all \n"
                read -r -p "Module names separated by space: " -a arr
                default
                for module in "${arr[@]}"; do
                $module
                done

        elif [[ $env == "PROD" ]]
        then
                cd /tmp ; git clone -b ultra git@gitlab.com:harshit.wadhawan/terraform.git
                cd terraform ; terraform init
                echo -e "\n${CYAN}${BOLD}Please choose the modules you want to deploy\n\n1. rms_ola \n2. pam \n3. weaver \n4. sle \n5. ige \n6. dms \n7. web_game \n8. sbs_vs \n9. portal_web \n10. all \n"
                read -r -p "Module names separated by space: " -a arr
                default
                for module in "${arr[@]}"; do
                $module
                done

        elif [[ $env == "none" ]]
        then
                cd /tmp ; git clone -b prod git@gitlab.com:harshit.wadhawan/terraform.git
                cd terraform ; terraform init
                echo -e "\n${CYAN}${BOLD}Please choose the modules you want to deploy\n\n1. rms_ola \n2. pam \n3. weaver \n4. sle \n5. ige \n6. dms \n7. web_game \n8. sbs_vs \n9. all \n"
                read -r -p "Module names separated by space: " -a arr
                default
                db
                for module in "${arr[@]}"; do
                $module
                done

        else
                        exit 1
        fi

#################################################### DESTRUCTION ############################################################

elif [[ $action == "DESTROY" ]]
then
        if [[ $env == "UAT" ]]
        then
             cd /tmp/terraform ; terraform init ; terraform destroy \--var-file=$path


        elif [[ $env == "PROD" ]]
        then
                cd /tmp/terraform ; terraform init ; terraform destroy \--var-file=$path

        else
                        exit 1
        fi
fi
