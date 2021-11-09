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

provider "aws" {
  alias    = "peer"
  region   = var.aws_peer_region
  profile  = var.aws_peer_profile
}

