terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.37.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

}

/*provider "aws" {
  alias    = "peer"
  region   = var.aws_peer_region
  #shared_credentials_file = "~/.aws/credentials"
  profile  = var.aws_peer_profile
  # assume_role {
  #   # role_arn = "arn:aws:iam::604795023295:role/assumevpc"
  #   # session_name = "Peer Session"
  #   # #external_id = "test"
  # }
}*/
