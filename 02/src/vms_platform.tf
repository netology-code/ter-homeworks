#####my vars
variable "vm_web_ubuntu-2004-lts" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}


variable "default_cidr-b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


variable "vm_web_netology-develop-platform-web" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "netology-develop-platform-web"
}

variable "vm_web_standard-v3" {
  type        = string
  default     = "standard-v3"
  description = "standard-v3"
}

variable "vm_web_cores" {
  type        = number
  default     = "2"
  description = "cores"
}

variable "vm_web_memory" {
  type        = number
  default     = "1"
  description = "vm_web_memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = "20"
  description = "core_fraction"
}

#############################################################

variable "vm_db_ubuntu-2004-lts" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "vm_db_netology-develop-platform-db" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "netology-develop-platform-db"
}

variable "vm_db_standard-v3" {
  type        = string
  default     = "standard-v3"
  description = "standard-v3"
}

variable "vm_db_cores" {
  type        = number
  default     = "2"
  description = "cores"
}

variable "vm_db_memory" {
  type        = number
  default     = "2"
  description = "vm_db_memory"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = "20"
  description = "core_fraction"
}


variable "default_zone-b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name-b" {
  type        = string
  default     = "net-ru-central1-b"
  description = "VPC network & subnet name"
}


###################################