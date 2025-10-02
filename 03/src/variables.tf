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

variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex compute image family name"
}

### vm WEB vars

variable "vm_web_configs" {
  description = "VMs web configs"
  default = {

      cores       = 2
      memory      = 2
      disk_size   = 10
      core_fraction = 5
      platform_id = "standard-v1"
      scheduling_policy = {
          preemptible = true
 
    }
  }
}

### vm DB vars

variable "vm_db_configs" {
  description = "VMs DB configs"
  default = {
    main = {
      cores       = 2
      memory      = 2
      disk_size   = 15
      core_fraction = 5
      platform_id = "standard-v1"
      scheduling_policy = {
        preemptible = true
      }
    }
    replica = {
      cores       = 4
      memory      = 4
      disk_size   = 10
      core_fraction = 5
      platform_id = "standard-v1"
      scheduling_policy = {
        preemptible = true
      }
    }
  }
}

### vm storage vars

variable "vm_storage_configs" {
  description = "VMs disk storage configs"
  default = {
      cores       = 2
      memory      = 2
      disk_size   = 10
      core_fraction = 5
      platform_id = "standard-v1"
      scheduling_policy = {
      preemptible = true
    }
  }
}

### disks vars

variable "storage_disks_configs" {
  description = "storage disks configs"
  default = {
    type = "network-hdd"
    disk_size = 1
  }
}