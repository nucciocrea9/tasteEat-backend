provider "aws" {
  version = "~> 3.0"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

module "website" {
  source = "./website"
  
  s3_origin_id  = "s3OriginId"
  bucket_prefix = "taste-eat-website-"
 
  providers = {
    aws = "aws"
  }
}

module "website-west" {
  source = "./website"
  
  s3_origin_id  = "s3OriginId"
  bucket_prefix = "taste-eat-website-"
 
 providers = {
    aws = "aws.us-west-1"
  }
}

locals {
  ##to avoid collitions if we want to deploy multiple with a single aws account
  user_pool_domain = "taste-user-pool-${random_string.id.result}"
  website          = "https://${module.website.domain_name}/"
}

module "authorization" {
  source = "./authorization"

  region           = var.region
  website          = local.website
  user_pool_domain = local.user_pool_domain

}


module "storage" {
  source = "./storage"
   providers = {
    aws = "aws"
  }
  //region = var.region

}

module "storage_west" {
    source = "./storage"
    providers = {
    aws = "aws.us-west-1"
  }

}


module "database" {
  source = "./database"
  
}
/*
module "database_west" {
  source= "./database"
  providers = {
    aws = "aws.us-west-1"
  }
}
*/

resource "random_string" "id" {
  length  = 6
  special = false
  upper   = false
}
