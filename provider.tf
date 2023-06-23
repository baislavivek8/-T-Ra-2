terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.37.0"
    }
  }
}

/*provider "aws" {
  region = "us-west-2"
  profile = "test"
}*/


/*provider "aws" {
  region = var.aws_region
}*/

provider "aws" {
  //alias   = "current"
  region  = var.aws_region
  //shared_credentials_file = "C:/Users/Administrator/.aws/credentials"
  profile = "default"

}

/*provider "aws" {
  alias                   = "peer"
  region                  = var.aws_peer_region
  shared_credentials_file = "~/.aws/credentials"
  profile = "demo"
  assume_role {
    role_arn = "arn:aws:iam::604795023295:role/assumevpc"
    session_name = "Peer Session"
    #external_id = "test"
  }
}*/
