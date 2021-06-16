#!/bin/bash

BOLD='\033[1m'
CYAN='\033[1;36m'

echo -e "${CYAN}${BOLD}Please select the environment you want to deploy"
read -p "Environment :" env

	if [ env -eq "uat" ]
	then
		cd C:\Users\Administrator\AppData\Local\Temp ; git clone - b uat https://gitlab.com/harshit.wadhawan/terraform.git
		exit 0

	elif [ env -eq "prod" ]
	then
		cd C:\Users\Administrator\AppData\Local\Temp ; git clone - b prod https://gitlab.com/harshit.wadhawan/terraform.git
		exit 0
	else
			exit 1

