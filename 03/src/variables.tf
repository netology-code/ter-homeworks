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

variable "default_resources" {
  type = object({platform=string,disk_type=string,resources=map(number)})
  description = "Default min resources"
  default = {
    resources = {
      cores = 2
      memory = 1
      core_fraction = 5
      disk_size = 5
    }
    platform = "standard-v2"
    disk_type = "network-hdd"
  }
}

variable "each_vm" {
  type = list(object({
    vm_name = string
    cores = number
    memory = number
    disk_size = number
    core_fraction = number
  }))
  description = "Resources for DB VM master and replica"
  default = [
    {
      vm_name = "main"
      cores = 4
      memory = 4
      disk_size = 20
      core_fraction = 100
    },
    {
      vm_name = "replica"
      cores = 2
      memory  = 2
      disk_size = 10
      core_fraction = 20
    }
  ]
}


variable "company" {
  type        = string
  default     = "netology"
}

variable "environment" {
  type        = string
  default     = "develop"
}

variable "project_name" {
  type        = string
  default     = "platform"
}

variable "vm_role" {
  type        =  list(string)
  default     =  ["web", "db"]
}