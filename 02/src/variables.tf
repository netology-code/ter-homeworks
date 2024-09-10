###cloud vars
/*variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}*/

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_platform_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "vms" {
  type = map(object({
    name        = string
    platform_id = string
    resources   = object({
      core = number
      memory = number
      core_fraction = number 
    })
    scheduling_policy = object({
      preemptible = bool
    })
    network_interface = object({
      nat = bool
    })
    metadata = object({
      serial-port-enable = number
      ssh-user = string
    })
    true_flg = bool
  }))
  default = {
      "web" = {
        name = "platform-web"
        platform_id = "standard-v1"
        resources = {
          core=2
          memory=1
          core_fraction=5
        }
        scheduling_policy = {
          preemptible = true
        }
        network_interface = {
          nat = true
        }
        metadata = {
          serial-port-enable = 1
          ssh-user  = "ubuntu"
        }
        true_flg = true 
      }
      "db" = {
        name = "platform-db"
        platform_id = "standard-v1"
        resources = {
          core=2
          memory=2
          core_fraction=20
        }
        scheduling_policy = {
          preemptible = true
        }
        network_interface = {
          nat = true
        }
        metadata = {
          serial-port-enable = 1
          ssh-user  = "ubuntu"
        }
        true_flg = true 
      }
  }
}

/*variable "vm_web_platform" {
  type    = object({
    name        = string
    platform_id = string
    resources   = object({
      core = number
      memory = number
      core_fraction = number 
    })
    scheduling_policy = object({
      preemptible = bool
    })
    network_interface = object({
      nat = bool
    })
    metadata = object({
      serial-port-enable = number
      ssh-user = string
    })
    true_flg = bool
  })
  default = {
    name = "platform-web"
    platform_id = "standard-v1"
    resources = {
      core=2
      memory=1
      core_fraction=5
    }
    scheduling_policy = {
      preemptible = true
    }
    network_interface = {
      nat = true
    }
    metadata = {
      serial-port-enable = 1
      ssh-user  = "ubuntu"
    }
    true_flg = true 
  } 
}*/