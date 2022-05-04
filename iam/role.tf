# aws_iam_role.authenticated:
resource "aws_iam_role" "authenticated" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRoleWithWebIdentity"
          Condition = {
            "ForAnyValue:StringLike" = {
              "cognito-identity.amazonaws.com:amr" = "authenticated"
            }
            StringEquals = {
              "cognito-identity.amazonaws.com:aud" = [var.identity_pool_id, var.identity_pool_id_west]
              //aws_cognito_identity_pool.identities_pool.id
            }
          }
          Effect = "Allow"
          Principal = {
            Federated = "cognito-identity.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  force_detach_policies = true
  max_session_duration  = 3600
  name                  = "tasteEat_idp_Auth_role"
  tags                  = {}
}

# aws_iam_role.unauthenticated:
resource "aws_iam_role" "unauthenticated" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRoleWithWebIdentity"
          Condition = {
            "ForAnyValue:StringLike" = {
              "cognito-identity.amazonaws.com:amr" = "unauthenticated"
            }
            StringEquals = {
              "cognito-identity.amazonaws.com:aud" = [var.identity_pool_id, var.identity_pool_id_west]
              //aws_cognito_identity_pool.identities_pool.id
            }
          }
          Effect = "Allow"
          Principal = {
            Federated = "cognito-identity.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  force_detach_policies = true
  max_session_duration  = 3600
  name                  = "tasteEat_idp_Unauth_role"
  tags                  = {}
}
