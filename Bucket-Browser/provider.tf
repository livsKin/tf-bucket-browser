terraform {
  cloud {
    organization = "boohoo-devops"
    hostname     = "app.terraform.io"

    workspaces {
      name = "api-gateway-project" # create new one
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}