variable "default_zone" {
  type        = string
}

variable "yandex_compute_image"{
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "default_cidr" {
  type        = list(string)
  description = "ipv4 cidr"
}

variable "vpc_name" {
  type        = string
}

variable "metadata" {
  type        = map(string)
  default = {}
}

variable "each_vm" {
  type = map(object({
    platform_id=string
    vm_name=string
    cpu=number
    ram=number
    core_fraction=number
    type=string
    disk_volume=number
    network_interface=bool
    scheduling_policy=bool
    }))
  default = {
    "dev" = {
      platform_id="standard-v2"
      vm_name="dev"
      cpu=2
      ram=1
      core_fraction=5
      type="network-hdd"
      disk_volume=10
      network_interface=true
      scheduling_policy=true
    }
    "ops" = {
      platform_id="standard-v3"
      vm_name="ops"
      cpu=4
      ram=2
      core_fraction=20
      type="network-hdd"
      disk_volume=20
      network_interface=true
      scheduling_policy=true      
    }
  }
}