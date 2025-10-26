# Переменные первой ВМ

variable "vm_web_name" {
  type    = string
  default = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v3"
}

#variable "vm_web_cores" {
#  type    = number
#  default = 2
#}

#variable "vm_web_memory" {
#  type    = number
#  default = 1
#}

#variable "vm_web_core_fraction" {
#  type    = number
#  default = 20
#}

#variable "vm_web_preemptible" {
#  type    = bool
#  default = true
#}

variable "vm_web_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

# Переменные второй ВМ

variable "vm_db_name" {
  type    = string
  default = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type    = string
  default = "standard-v3"
}

#variable "vm_db_cores" {
#  type    = number
#  default = 2
#}

#variable "vm_db_memory" {
#  type    = number
#  default = 2
#}

#variable "vm_db_core_fraction" {
#  type    = number
#  default = 20
#}

#variable "vm_db_preemptible" {
#  type    = bool
#  default = true
#}

variable "vm_db_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_db_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "vm_db_cidr" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

# переменная для ресурсов ВМ
variable "vms_resources" {
  description = "Ресурсы для ВМ"
  type = map(object({
    cores          = number
    memory         = number
    core_fraction  = number
    hdd_size       = number
    hdd_type       = string
    preemptible    = bool
  }))
}

# переменная для metadata
variable "vms_metadata" {
  description = "метадата для ВМ"
  type        = map(string)
}

