module "cognito-idp" {
  source = "./modules/cognito-idp"
  #identity_pool_name = var.idp_name
}

module "s3" {
  source = "./modules/s3"
  bucket = var.bucket
}

