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
  source = "./modules/Ec2"
  account_id   = data.aws_caller_identity.current.account_id
  aws_region = var.aws_region
  client_name   = var.client_name
  #domain_name = var.domain_name
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  #aws_natgateway_ips = module.vpc.aws_natgateway_ips
  aws_public_subnet = module.vpc.aws_public_subnet
  aws_private_subnet = module.vpc.aws_private_subnet
  #db_port = var.db_port
  #db_instance_class = var.db_instance_class
  #master_user = var.master_user
  #master_password = var.master_password
  #max_prepared_transactions = var.max_prepared_transactions
  #vpn_port_22_security_group_id = var.vpn_port_22_security_group_id
  #alb_account_id = var.alb_account_id
  #max_connections = var.max_connections
  #work_mem = var.work_mem
  #audit_trail_enabled = var.audit_trail_enabled
  ami_id = var.ami_id
}

/*module "vpc_peering" {
  source    = "./modules/vpc_peering"
  
  providers = {
    aws.peer = aws.peer
  }

  peer_region                = var.aws_region
  vpc_id                     = module.vpc.vpc_id
  peer_vpc_id                = var.peer_vpc_id
  peer_owner_id              = data.aws_caller_identity.peer.account_id
  accepter_cidr_block        = var.peer_cidr
  requester_cidr_block       = var.vpc_cidr
  route_table_id             = module.vpc.private_route_tables
  accepter_intra_subnet_name = var.accepter_intra_subnet_name["peer"]
  aws_peer_region            = var.aws_peer_region
  

}*/