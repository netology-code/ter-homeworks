#WEB config
variable "vm_web_" {
  type = object({
    #name         = string
    platform_id  = string
    zone         = string
    #resources = object({
      #cores         = number
      #memory        = number
      #core_fraction = number
    #})
    scheduling_policy = object({
      preemptible = bool
    })
    network_interface = object({
      nat = bool
    })
    #metadata = object({
      #serial-port-enable = number
    #})
  })
  default = {
    #name         = "netology-develop-platform-web"
    platform_id  = "standard-v1"
    zone         = "ru-central1-a"
    #resources = {
      #cores         = 2
      #memory        = 1
      #core_fraction = 5
    #}
    scheduling_policy = {
      preemptible = true
    }
     network_interface = {
       nat = true
     }
    #metadata = {
      #serial-port-enable = 1
    #}
  }
  description = "Configuration WEB"
}

#DB config
variable "vm_db_" {
  type = object({
    #name         = string
    platform_id  = string
    zone         = string
    #resources = object({
      #cores         = number
      #memory        = number
      #core_fraction = number
    #})
    scheduling_policy = object({
      preemptible = bool
    })
    network_interface = object({
      nat = bool
    })
   #metadata = object({
      #serial-port-enable = number
    #})
  })
  default = {
    #name         = "netology-develop-platform-db"
    platform_id  = "standard-v1"
    zone         = "ru-central1-b"
    #resources = {
      #cores         = 2
      #memory        = 2
      #core_fraction = 20
    #}
    scheduling_policy = {
      preemptible = true
    }
     network_interface = {
       nat = true
     }
    #metadata = {
      #serial-port-enable = 1
    #}
  }
  description = "Configuration DB"
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

#variable "vms_ssh_public_root_key" {
  #type        = string
  #default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJXrG37ahpXCptSBiQG4ukIF6X+Xm6NyY0zlsUlXn0DX root@docker"
  #description = "ssh-keygen -t ed25519"
#}