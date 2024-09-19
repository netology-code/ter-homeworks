###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
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


variable "vm_web_yandex_compute_image_family" {
    type    = string
    default = "ubuntu-2004-lts"
}

variable "vm_web_yandex_compute_instance_name" {
    type    = string
    default = "netology-develop-platform-web"
}

variable "vm_web_yandex_compute_instance_platform_id" {
    type    = string
    default = "standard-v1"
}

variable "vm_web_yandex_compute_instance_resources_cores" {
    type    = number
    default = 2
}

variable "vm_web_yandex_compute_instance_resources_memory" {
    type    = number
    default = 1
}

variable "vm_web_yandex_compute_instance_resources_core_fraction" {
    type    = number
    default = 5
}

###ssh vars
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbFQwlXpyF5D6x8yiptgTG/Are3CfQ94MRINvltKRs2 root@nt.ksob.lan"
  description = "ssh-keygen -t ed25519"
}
