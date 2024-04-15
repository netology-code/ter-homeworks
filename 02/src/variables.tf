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

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  }
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  }
variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v2"
  }
variable "vm_web_recources_core" {
  type        = number
  default     = "2"
  }
variable "vm_web_recources_memory" {
  type        = number
  default     = "2"
  }
variable "vm_web_recources_core_fraction" {
  type        = number
  default     = "5"
  description = "guaranteed vCPU, for yandex cloud - 20, 50 or 100 "
  }
variable "vm_web_scheduling_policy_preemptible" {
  type        = bool
  default     = true
  }

variable "vm_web_boot_disk_image_id" {
  type        = string
  default     = "data.yandex_compute_image.ubuntu.image_id"
  }

variable "vm_web_network_interface_network_id" {
  type        = string
  default     = "yandex_vpc_subnet.develop.id"
  }


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "4ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkSL7MyZ/ONOD1efFYMYB7QuQoTjXBYu0/rTD6Y6vi1 debian@debian"
  description = "ssh-keygen -t ed25519"
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

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db" 
  }

variable "vpc_name_db" {
  type        = string
  default     = "db"
  description = "VPC network & subnet name"
}


###vars for locals.tf

variable "instance" {
  type        = string
  default = "netology-develop-platform"
}

variable "name_web" {
  type        = string
  default = "web"
}

variable "name_db" {
  type        = string
  default = "db"
}