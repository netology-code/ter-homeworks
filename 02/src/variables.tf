###cloud vars


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

variable "subnet_b_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "subnet_b_cidr" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "subnet_b_name" {
  type    = string
  default = "develop-b"
}

###ssh vars

#variable "vms_ssh_public_root_key" {
#  type        = string
#  description = "ssh-keygen -t ed25519"
#}


variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
}

variable "metadata" {
  type = map(string)
}
