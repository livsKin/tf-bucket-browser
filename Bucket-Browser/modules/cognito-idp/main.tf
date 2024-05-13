resource "aws_cognito_identity_pool" "browser_idp" {
  identity_pool_name = var.idp_name
  allow_unauthenticated_identities = true

  /*cognito_identity_providers {     # block specifies a user pool client and user pool provider for the identity pool
    client_id = aws_cognito_user_pool_client.browser_idp.id
    provider_name = aws_cognito_user_pool.browser_idp.endpoint
    server_side_token_check = true
  }


    depends_on = [
    aws_cognito_user_pool_client.browser_idp,
    aws_cognito_user_pool.browser_idp,
  ]*/
  
}

resource "aws_cognito_identity_pool_roles_attachment" "idp_role" {
  identity_pool_id = aws_cognito_identity_pool.browser_idp.id

  roles = {
    #authenticated = aws_iam_role.authenticated.arn
    unauthenticated = aws_iam_role.unauthenticated_role.arn
  }
}

# THE ROLE FOR UNAUTH USER 

resource "aws_iam_role" "unauthenticated_role" {
  name = "example-unauthenticated"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "cognito-identity.amazonaws.com:aud" = aws_cognito_identity_pool.browser_idp.id
          }
        }
      },
    ]
  })
}

  /*resource "aws_cognito_identity_provider" "javascript_platform" {
  provider_name = "Cognito"
  provider_type = "SAML"
}*/

# THE POLICY ATTACHED TO UNAUTH USER TO VIEW ALBUM ETC. 

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "to view albums and photos policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Resource": [
        "arn:aws:s3:::browser-bucket-idp",
        "arn:aws:s3:::browser-bucket-idp/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  policy_arn = aws_iam_policy.s3_access_policy.arn
  role       = aws_iam_role.unauthenticated_role.name
}



