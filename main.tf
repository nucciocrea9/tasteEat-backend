provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
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

module "authorization" {
  source               = "./authorization"
  authenticated_role   = module.iam.authenticated_role
  unauthenticated_role = module.iam.unauthenticated_role
  region               = var.region
  website              = "https://${module.website.domain_name}/"
  user_pool_domain     = "taste-user-pool-${random_string.id.result}"
  providers = {
    aws = "aws"
  }
}

module "authorization-west" {
  source               = "./authorization"
  authenticated_role   = module.iam.authenticated_role
  unauthenticated_role = module.iam.unauthenticated_role
  region               = var.region-eu
  website              = "https://${module.website-west.domain_name}/"
  user_pool_domain     = "taste-user-pool-${random_string.id-west.result}"
  providers = {
    aws = "aws.us-west-1"
  }
}

module "iam" {
  source                = "./iam"
  identity_pool_id      = module.authorization.identity_pool
  identity_pool_id_west = module.authorization-west.identity_pool
}
module "storage" {
  source = "./storage"
  cognitoRole = module.iam.authenticated_role
  providers = {
    aws = "aws"
  }


}

module "storage_west" {
  source = "./storage"
  cognitoRole = module.iam.authenticated_role
  providers = {
    aws = "aws.us-west-1"
  }

}


module "database" {
  source = "./database"

}
resource "random_string" "id-west" {
  length  = 6
  special = false
  upper   = false

}

resource "random_string" "id" {
  length  = 6
  special = false
  upper   = false

}
