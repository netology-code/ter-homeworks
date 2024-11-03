###cloud vars

variable "default_cidr_for_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "subnet_name_b" {
  type        = string
  default     = "develop-b"
  description = "VPC network & subnet name"
}

variable "vm_db_yandex_compute_image"{
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image name for VM"
}

variable "vm_db_yandex_compute_instance_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name and hostname for VM"
}

variable "vm_db_yandex_compute_instance_platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Platform type of VM"
}

# variable "vm_db_resources" {
#   type        = object({ cores = number, memory = number, core_fraction = number })
#   default     = { cores = 2, memory = 2, core_fraction = 20 }
#   description = "Resources of yandex compute image"
# }

# variable "vm_db_initialize_params" {
#   type        = object({ type = string, size = number })
#   default     = { type = "network-hdd", size = 10 }
#   description = "Params for yandex VM disk"
# }

variable "vm_db_scheduling_policy" {
    type      = bool
    default   = true
}
variable "vm_db_network_interface" {
    type      = bool
    default   = true
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
