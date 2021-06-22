#!/bin/bash

BOLD='\033[1m'
CYAN='\033[1;36m'

echo -e "${CYAN}${BOLD}Please select the environment you want to deploy !\n\n1. UAT \n2. PROD"
read -p "Environment :" env
echo -e "${CYAN}${BOLD}Please provide the absolute path of the Terraform Variables file"
read -p "Terraform Variables File Path :" env-path

        if [[ $env == "UAT" ]]
        then
                cd /tmp ; git clone -b uat git@gitlab.com:harshit.wadhawan/terraform.git
                terraform plan --var-file=$env-path
                exit 0

        elif [[ $env == "PROD" ]]
        then
                cd /tmp ; git clone -b prod git@gitlab.com:harshit.wadhawan/terraform.git
                terraform plan --var-file=$env-path
                exit 0
        else
                        exit 1

fi
