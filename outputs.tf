output "USER_POOL_ID" {
  value = module.authorization.user_pool
}

output "USER_POOL_SUBDOMAIN" {
  value = "taste-user-pool-${random_string.id.result}"
}

output "CLIENT_ID" {
  value = module.authorization.client_id
}

output "IDENTITY_POOL_ID" {
  value = module.authorization.identity_pool
}

output "BUCKET_NAME" {
  value = module.storage.bucket.bucket
}

output "REGION" {
  value = var.region
}

output "SIGNIN_REDIRECT_URL" {
  value = "https://${module.website.domain_name}/"
}

output "SIGNOUT_REDIRECT_URL" {
  value = "https://${module.website.domain_name}/"
}
###
output "WEBSITE_URL" {
  value = "https://${module.website.domain_name}/"
}

output "HOSTING_BUCKET" {
  value = module.website.hosting_bucket
}



output "USER_POOL_ID_west" {
  value = module.authorization-west.user_pool
}

output "USER_POOL_SUBDOMAIN_west" {
  value = "taste-user-pool-${random_string.id-west.result}"
}

output "CLIENT_ID_west" {
  value = module.authorization-west.client_id
}

output "IDENTITY_POOL_ID_west" {
  value = module.authorization-west.identity_pool
}

output "BUCKET_NAME_west" {
  value = module.storage_west.bucket.bucket
}

output "REGION_west" {
  value = var.region
}

output "SIGNIN_REDIRECT_URL_west" {
  value = "https://${module.website-west.domain_name}/"
}

output "SIGNOUT_REDIRECT_URL_west" {
  value = "https://${module.website-west.domain_name}/"
}
###
output "WEBSITE_URL_west" {
  value = "https://${module.website-west.domain_name}/"
}

output "HOSTING_BUCKET_west" {
  value = module.website-west.hosting_bucket
}
