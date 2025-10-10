variable "yc_token" {
  type        = string
  description = "Yandex Cloud OAuth token"
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "yc_zone" {
  type        = string
  description = "Yandex Cloud Zone"
  default     = "ru-central1-a"
}

variable "yc_access_key" {
  type        = string
  description = "Yandex Cloud Storage access key"
}

variable "yc_secret_key" {
  type        = string
  description = "Yandex Cloud Storage secret key"
}