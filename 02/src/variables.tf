###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default = "b1gebvnp4l01pjj94h8g"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default = "b1gll1nj110e9uebdvrq"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

# provider "yandex" {
#   # token                    = "auth_token_here"
#   cloud_id                 = "b1gebvnp4l01pjj94h8g"
#   folder_id                = "b1gll1nj110e9uebdvrq"
#   zone                     = "ru-central1-a"
# }

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEF1s4DWFbHRG8VeGu9PXvAdkLp7SPsbklk63Soan+RC"
  description = "ssh-keygen -t ed25519"
}
