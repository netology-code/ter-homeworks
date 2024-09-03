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

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}
variable "name_zone-a" {
  type        = string
  default     = "develop-ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_zone-a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr-zone-a" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "name_zone-b" {
  type        = string
  default     = "develop-ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_zone-b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr-zone-b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_yandex_compute_image_family" {
    type    = string
    default = "ubuntu-2004-lts"
}

variable "project" {
    type    = string
    default = "netology"
}
variable "env" {
    type    = string
    default = "develop"
}

variable "vm_web_yandex_compute_instance_name" {
    type    = string
    default = "${local.name}--platform-web"
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

variable "vm_db_yandex_compute_instance_name" {
    type    = string
    default = "${local.name}--platform-db"
}
variable "vm_db_yandex_compute_instance_platform_id" {
    type    = string
    default = "standard-v1"
}
variable "vm_db_yandex_compute_instance_resources_cores" {
    type    = number
    default = 2
}
variable "vm_db_yandex_compute_instance_resources_memory" {
    type    = number
    default = 2
}
variable "vm_db_yandex_compute_instance_resources_core_fraction" {
    type    = number
    default = 20
}


###ssh vars
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbFQwlXpyF5D6x8yiptgTG/Are3CfQ94MRINvltKRs2 root@nt.ksob.lan"
  description = "ssh-keygen -t ed25519"
}
