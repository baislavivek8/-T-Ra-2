#Get AWS Account ID of main Account
data "aws_caller_identity" "current" {}

/*data "aws_caller_identity" "peer" {
  provider = aws.peer
}*/

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

module "backend" {
  source = "./modules/backend"
  account_id   = data.aws_caller_identity.current.account_id
  aws_region = var.aws_region
  client_name   = var.client_name
  domain_name = var.domain_name
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  aws_natgateway_ips = module.vpc.aws_natgateway_ips
  aws_public_subnet = module.vpc.aws_public_subnet
  aws_private_subnet = module.vpc.aws_private_subnet
  db_port = var.db_port
  db_instance_class = var.db_instance_class
  master_user = var.master_user
  master_password = var.master_password
  max_prepared_transactions = var.max_prepared_transactions
  vpn_port_22_security_group_id = var.vpn_port_22_security_group_id
  #alb_account_id = var.alb_account_id
  max_connections = var.max_connections
  work_mem = var.work_mem
  audit_trail_enabled = var.audit_trail_enabled
  ami_id = var.ami_id
}

module "vpc_peering" {
  source    = "./modules/vpc_peering"
  
  providers = {
    aws.dst = aws.peer
  }

  vpc_id          = module.vpc.vpc_id
  route_table_id  = module.vpc.private_route_tables
  vpc_cidr        = var.vpc_cidr
  aws_peer_region = var.aws_peer_region
  client_name     = var.client_name
  environment     = var.environment

}