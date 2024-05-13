# S3 VARS

variable "bucket" {
  type        = string
  description = "The name of the S3 used as a reference"
  default     = "browser-bucket-idp"
}

# COGNITO IDP VARS

variable "idp_name" {
  type        = string
  description = "The name of the identity pool name"
  default     = "browser-identity-pool"
}

variable "role_auth" {
  type        = string
  description = "The name of the identity pool role for authenticated user"
  default     = "idp-role-authenticated"
}

variable "role_unauth" {
  type        = string
  description = "The name of the identity pool role for unauthenticated user"
  default     = "idp-role-unauthenticated"
}

