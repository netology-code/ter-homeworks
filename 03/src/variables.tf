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

variable "vm_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "os-version"
}
# VM web resources
variable "vm_web_resources" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

variable "resources_list" {
  type = list(object(
    {
      vm_name = string
      cpu     = number
      ram     = number
      disk    = number
  }))
  default = [
    {
      vm_name = "yandex_compute_image.vm.name"
      cpu     = 2
      ram     = 2
      disk    = 10
    }
  ]
}

# Common metadata
variable "common_metadata" {
  type = map(string)
  description = "ssh credentials"
}

variable "storage" {
  description = "Create disk"
  type = map
  default = {
    name = "new-storage"
    type = "network-hdd"
    zone = "ru-central1-a"
    size = 1
  }
}

variable "vm_platforms" {
  type = string
  default = "standard-v1"
}