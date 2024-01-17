

variable "default_zone2" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr2" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name2" {
  type        = string
  default     = "db"
  description = "VPC network & subnet name"
}

variable "vm_db_image" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "env1" {
  type    = string
  default = "develop"
}

variable "project1" {
  type    = string
  default = "platform"
}

variable "role1" {
  type    = string
  default = "db"
}


variable "vm_db_resource" {
  type = list(object({
    #instance_name = string
    #instance_cores         = number
    #instance_memory        = number
    #instance_core_fraction = number
    public_ip   = bool
    platform    = string
    preemptible = bool
  }))
  default = [
    {
      #instance_name = "netology-develop-platform-db"
      #instance_cores         = 2
      #instance_memory        = 2
      #instance_core_fraction = 20
      public_ip   = true
      platform    = "standard-v1"
      preemptible = true

    }
  ]
}
