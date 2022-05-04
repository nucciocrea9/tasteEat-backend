output "user_pool" {
  value = aws_cognito_user_pool.users_pool.id
}

output "user_pool_arn" {
  value = aws_cognito_user_pool.users_pool.arn
}

output "client_id" {
  value = aws_cognito_user_pool_client.web_client.id
}

output "identity_pool" {
  value = aws_cognito_identity_pool.identities_pool.id
}
