###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}


variable "id" {
  type = object({
    cloud_id  = string
    folder_id = string
  })
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

variable "vm_web_image" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "env" {
  type    = string
  default = "develop"
}

variable "project" {
  type    = string
  default = "platform"
}

variable "role" {
  type    = string
  default = "web"
}


variable "metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys           = string
  })
}


variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
}

variable "vm_web_resource" {
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
      #instance_name = "netology-develop-platform-web"
      #instance_cores         = 2
      #instance_memory        = 1
      #instance_core_fraction = 5
      public_ip   = true
      platform    = "standard-v1"
      preemptible = true

    }
  ]
}

###ssh vars

/*
variable "vms_ssh_root_key" {
  type        = string
  default     = "...."
  description = "ssh-keygen -t ed25519"
}
*/
