resource "aws_s3_bucket" "browser_bucket" {
  bucket = var.bucket

  tags = {
    Name        = "Browser Bucket"
    Environment = "Sandbox"
  }
}

resource "aws_s3_bucket_public_access_block" "block_access" {
  block_public_acls       = false           # allow new public acls to be created 
  block_public_policy     = false           # allow new public policies to be created
  ignore_public_acls      = false           # remove public access granted through public ACLs
  restrict_public_buckets = false

  bucket = aws_s3_bucket.browser_bucket.id
}

resource "aws_s3_bucket_cors_configuration" "browser_bucket_cors" {
  bucket = aws_s3_bucket.browser_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["HEAD", "GET"]
    allowed_origins = ["*"]
   }
}

#  CREATE MULTIPLE FOLDERS IN A SINGLE BUCKET

locals {
  folders = [
    for folder in var.s3_folder_names:
      "${var.folder}/${folder}"
  ]
}

resource "aws_s3_bucket_object" "folders" {
  for_each = var.create_folders ? {for folder in local.folders: folder => {} } : {}
  bucket   = var.bucket
  key      = format("%s/", each.key)
  content_type = "application/x-directory"
  #source   = "dev/null"
}

# Attach a policy to the bucket, BUCKET POLICY 
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.browser_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.browser_bucket.arn}",
        "${aws_s3_bucket.browser_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}






