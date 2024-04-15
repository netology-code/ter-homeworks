variable "vm_db_zone_b_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v2"
  description = "Platform for VM db"
}

###ssh vars

variable "vm_db_vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkSL7MyZ/ONOD1efFYMYB7QuQoTjXBYu0/rTD6Y6vi1 debian@debian"
  description = "ssh-keygen -t ed25519"
}




variable "vms_resources" {
  type        = map(map(number))
  description = "Resources for  VMs"
  default     = {
    vm_web_resources = {
      cores   = 2
      memory  = 1
      core_fraction = 5
    }
    vm_db_resources = {
      cores   = 2
      memory  = 2
      core_fraction = 20
    }
  }
}