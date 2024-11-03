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

variable "vm_web_yandex_compute_image"{
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image name for VM"
}

variable "vm_web_yandex_compute_instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name and hostname for VM"
}

variable "vm_web_yandex_compute_instance_platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Platform type of VM"
}

variable "vm_web_resources" {
  type        = object({ cores = number, memory = number, core_fraction = number })
  default     = { cores = 2, memory = 1, core_fraction = 5 }
  description = "Resources of yandex compute image"
}

variable "vm_web_initialize_params" {
  type        = object({ type = string, size = number })
  default     = { type = "network-hdd", size = 10 }
  description = "Params for yandex VM disk"
}

variable "vm_web_scheduling_policy" {
    type      = bool
    default   = true
}
variable "vm_web_network_interface" {
    type      = bool
    default   = true
}

variable "vm_web_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


# provider "yandex" {
#   token                    = "auth_token_here"
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
