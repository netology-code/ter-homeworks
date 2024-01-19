
variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "default_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_count" {
  type        = number
  description = "Number of VMs to create"
}

variable "db_vm" {
  type = list(object({
    vm_name = string
    cores   = number
    memory  = number
    #disk          = number
    core_fraction = number
    #count          = number
    #boot_disk_type = string
    #boot_disk_size = number
    public_ip   = bool
    platform    = string
    preemptible = bool
  }))
  default = [
    {
      vm_name       = "main"
      cores         = 2
      memory        = 1
      core_fraction = 20
      public_ip     = true
      platform      = "standard-v1"
      preemptible   = true

    },
    {
      vm_name       = "replica"
      cores         = 1
      memory        = 2
      core_fraction = 10
      public_ip     = true
      platform      = "standard-v1"
      preemptible   = true

    }
  ]

}

variable "metadata" {
  type = map(string)
}

variable "vm_resource" {
  type = list(object({
    public_ip   = bool
    platform    = string
    preemptible = bool
  }))
  default = [
    {
      public_ip   = true
      platform    = "standard-v1"
      preemptible = true

    }
  ]
}
