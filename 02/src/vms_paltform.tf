# netology-develop-platform-web vars:

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "yandex compute instance name"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex compute image family name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1" #standart-v4 error
  description = "yandex compute instance platform id"
}

# variable "vm_web_resources_cores" {
#   type        = number
#   default     = 2
#   description = "yandex compute instance cores number"
# }

# variable "vm_web_resources_memory" {
#   type        = number
#   default     = 1
#   description = "yandex compute instance memory amount in Gb"
# }

# variable "vm_web_resources_core_fraction" {
#   type        = number
#   default     = 5
#   description = "yandex compute instance core fraction %"
# }

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "yandex compute instance preemptible"
}

variable "vm_web_network_nat" {
  type        = bool
  default     = false
  description = "yandex network nat use"
}

# variable "vm_web_serial_port" {
#   type        = number
#   default     = 1
#   description = "is serial port enable"
# }

# variable "vm_web_ssh_user" {
#   type        = string
#   default     = "ubuntu"
#   description = "Default SSH user for VMs"
# }

variable "vm_web_vpc_name" {
  type        = string
  default     = "develop-web"
  description = "VPC network & subnet name for develop web"
}

#netology-develop-platform-db vars:

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "yandex compute instance name"
}

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex compute image family name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex compute instance platform id"
}

# variable "vm_db_resources_cores" {
#   type        = number
#   default     = 2
#   description = "yandex compute instance cores number"
# }

# variable "vm_db_resources_memory" {
#   type        = number
#   default     = 2
#   description = "yandex compute instance memory amount in Gb"
# }

# variable "vm_db_resources_core_fraction" {
#   type        = number
#   default     = 20
#   description = "yandex compute instance core fraction %"
# }

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "yandex compute instance preemptible"
}

variable "vm_db_network_nat" {
  type        = bool
  default     = false
  description = "yandex network nat use"
}

# variable "vm_db_serial_port" {
#   type        = number
#   default     = 1
#   description = "is serial port enable"
# }

# variable "vm_db_ssh_user" {
#   type        = string
#   default     = "ubuntu"
#   description = "Default SSH user for VMs"
# }


variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone for DB VM"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop-db"
  description = "VPC network & subnet name for develop db"
}
