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
  value = module.website.domain_name
}

output "SIGNOUT_REDIRECT_URL" {
  value = module.website.domain_name
}
###
output "WEBSITE_URL" {
  value = module.website.domain_name
}

output "HOSTING_BUCKET" {
  value = module.website.hosting_bucket
}
