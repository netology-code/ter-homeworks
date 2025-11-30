variable "cloud_id" {
  type        = string
  description = "Yandex Cloud cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud folder ID"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for remote state"
  default     = "terraform-remote-state"
}

variable "service_account_name" {
  type        = string
  description = "Service account name for remote state"
  default     = "terraform-remote-state-sa"
}

variable "service_account_description" {
  type        = string
  description = "Service account description"
  default     = "Service account for managing Terraform remote state"
}

