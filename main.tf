#Get AWS Account ID of main Account
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

module "vpc" {
  source = "./modules/vpc"
  aws_region = var.aws_region
  client_name = var.client_name
  az_count = var.az_count
  environment = var.environment
  vpc_cidr = var.vpc_cidr

}

