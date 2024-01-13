###cloud vars
#variable "token" {
  #type        = string
  #description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  default     = "b1gnre1u46m6aek7gues"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gcn2qnmrs7g9fq1f50"
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

variable "vm_web_yandex_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image OC"
}

variable "vm_web_yandex_compute_instance" {
  type = object({
    name         = string
    platform_id  = string
    zone         = string
    resources = object({
      cores         = number
      memory        = number
      core_fraction = number
    })
    scheduling_policy = object({
      preemptible = bool
    })
    network_interface = object({
      nat = bool
    })

  })
  default = {
    name         = "netology-develop-platform-web"
    platform_id  = "standard-v1"
    zone         = "ru-central1-a"
    resources = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    scheduling_policy = {
      preemptible = true
    }
     network_interface = {
       nat = true
     }
  }
}


###ssh vars

variable "vms_ssh_public_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJXrG37ahpXCptSBiQG4ukIF6X+Xm6NyY0zlsUlXn0DX root@docker"
  description = "ssh-keygen -t ed25519"
}
