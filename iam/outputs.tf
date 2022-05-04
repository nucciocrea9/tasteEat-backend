output "authenticated_role" {
  value = aws_iam_role.authenticated.arn
}

output "unauthenticated_role" {
  value = aws_iam_role.unauthenticated.arn
}