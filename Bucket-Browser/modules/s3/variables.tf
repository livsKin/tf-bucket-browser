variable "bucket" {
  type        = string
  description = "The name of the S3 used as a reference"
  default     = "browser-bucket-idp"
}


variable "s3_folder_names" {
  type    = list(string)
  default = ["album1", "album2", "album3"]
}

variable "create_folders" {
  type    = bool
  default = true
}

variable "folder" {
  type        = string
  description = "The name of the S3 used as a reference"
  default     = ""
}

variable "local_folder_path" {
  type        = string
  description = "The name of the S3 used as a reference"
  default     = "./modules/s3/"
}

variable "folder_name" {
  type        = string
  description = "The name of the S3 used as a reference"
  default     = "album"
}

/*variable "local_folder_path_two" {
  type        = string
  description = "The name of the S3 used as a reference"
  default     = "./modules/s3/album2"
}

variable "folder_name_two" {
  type        = string
  description = "The name of the S3 used as a reference"
  default     = "album2"
}*/

