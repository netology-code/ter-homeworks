#WEB config
variable "vm_web_" {
  type = object({
    platform_id  = string
    zone         = string
    scheduling_policy = object({
      preemptible = bool
    })
    network_interface = object({
      nat = bool
    })
  })
  default = {
    platform_id  = "standard-v1"
    zone         = "ru-central1-a"
    scheduling_policy = {
      preemptible = true
    }
     network_interface = {
       nat = true
     }
  }
  description = "Configuration WEB"
}


#Map vars for resources
variable "vms_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
  }))
  default = {
    web = {
      cores = 2
      memory = 1
      core_fraction = 5
    }
    db = {
      cores = 2
      memory = 2
      core_fraction = 20
    }
  }
}

# Metadata
variable "metadata" {
  type = map
  default = {
    serial-port-enable = 1
    ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJXrG37ahpXCptSBiQG4ukIF6X+Xm6NyY0zlsUlXn0DX root@docker"
  }
}

#For locals.tf
variable "project" {
  type        = string
  default     = "netology-develop-platform"
  description = "Name project"
}

variable "instance" {
  type = object({
    db   = string
    web  = string
  })
  default = {
    db   = "db"
    web  = "web"
  }
  description = "Instances names"
}

variable "each_vm" {
  type = list(object({
    instance_count  = number
    instance_name   = string
    instance_cores  = number
    instance_memory = number
  }))
  default = [
    {
      instance_name   = "main"
      instance_count  = 1
      instance_cores  = 2
      instance_memory = 5
    },
    {
      instance_name   = "replica"
      instance_count  = 1
      instance_cores  = 2
      instance_memory = 5
    }
  ]
}