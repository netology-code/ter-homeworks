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
  description = "VPC network&subnet name"
}

variable "vm_web_yandex_compute_image"{
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image name for VM"
}

variable "vm_web_yandex_compute_instance_platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Platform type of VM"
}

variable "vm_web_scheduling_policy" {
    type      = bool
    default   = true
}

variable "vm_web_network_interface" {
    type      = bool
    default   = true
}

variable "vm_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    type          = string
    size          = number
  }))
  default = {
    "web" = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      type          = "network-hdd"
      size          = 10
    }
  }
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, core_fraction=number, type=string, disk_volume=number }))
}

variable "serial-port" {
  type        = number
  default     = 1
  description = "Common ssh params"
}

variable "ssh-key" {
  type        = string
  description = "Common ssh params"
}