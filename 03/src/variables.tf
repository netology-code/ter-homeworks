###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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
  description = "VPC network&subnet name"
}

###cloud vars #add

variable "public_key" {
  type    = string
#  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzqKwUDlLQy+gsAc6as6WUmctThf3uqdlHZPSRwn4OF"
  default = "~/.ssh/id_rsa_2048.pub"
#  default = file("~/.ssh/id_rsa_2048.pub") #!!!!!В таком виде не работает
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number, core_fraction=number }))
}
###########################3
variable "storage_disk_vm" {
  type        = string
  default     = "storage"
}

variable "boot_disk_disk_vm" {
  type        = number
  default     = "5"
}

variable "cores_disk_vm" {
  type        = number
  default     = "2"
}

variable "memory_disk_vm" {
  type        = number
  default     = "1"
}

variable "core_fraction_disk_vm" {
  type        = number
  default     = "5"
}
####################################
variable "boot_disk_count_vm" {
  type        = number
  default     = "5"
}

variable "cores_count_vm" {
  type        = number
  default     = "2"
}

variable "memory_count_vm" {
  type        = number
  default     = "1"
}

variable "core_fraction_count_vm" {
  type        = number
  default     = "20"
}
##########################
variable "platform_id" {
  type        = string
  default     = "standard-v1"
}

####################################