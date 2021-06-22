#!/bin/bash

BOLD='\033[1m'
CYAN='\033[1;36m'

echo -e "${CYAN}${BOLD}Please select the environment you want to deploy"
read -p "Environment :" env

        if [ $env=='uat' ]
        then
                cd /tmp ; git clone - b uat https://gitlab.com/harshit.wadhawan/                                                                                                             terraform.git ;
                #terraform apply --var-file=uat-vars.tfvars
                exit 0

        elif [ $env=='prod' ]
        then
                cd /tmp ; git clone - b prod https://gitlab.com/harshit.wadhawan/                                                                                                             /terraform.git ;
                #terraform apply --var-file=prod-vars.tfvars
                exit 0
        else
                        exit 1

fi