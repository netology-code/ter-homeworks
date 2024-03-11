###cloud vars

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIOERolx3KtJ5+3FufMC88MhcYISKmL28lYydyc4MGYV udjin@udjin-VirtualBox"
}


variable "default_resources" {
  type = object({platform=string,disk_type=string,resources=map(number)})
  description = "Default min resources"
  default = {
    resources = {
      cores = 2
      memory = 1
      core_fraction = 5
      disk_size = 5
    }
    platform = "standard-v2"
    disk_type = "network-hdd"
  }
}

variable "each_vm" {
  type = list(object({
    vm_name = string
    cores = number
    memory = number
    disk_size = number
    disk_type = string
  }))
  description = "Resources for DB VM master and replica"
  default = [
    {
      vm_name = "main"
      cores = 4
      memory = 4
      disk_size = 20
      disk_type = "network-hdd"
    },
    {
      vm_name = "replica"
      cores = 2
      memory  = 2
      disk_size = 10
      disk_type = "network-hdd"
    }
  ]
}