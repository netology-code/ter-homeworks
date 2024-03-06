###cloud vars
variable "cloud_id" {
  type        = string
  default     = "b1gjmftgjegm4ag26bp3"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gfqj3kv6rieiisg1p5"
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

variable "vm_web_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v2"
  description = "Platform for VM web"
}

###ssh vars

variable "common_ssh_root_key" {
  type        = map(string)
  default     =  {
    serial-port-enable = 1
    ssh-keys  = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIn66AMKG3i2jNcUItP9ZlzKPB2FlL9fCuYMi5AQnTDa root@terraform01"
    }
  description = "SSH root key for  all VMs"
}

variable "company" {
  type        = string
  default     = "netology"
}

variable "environment" {
  type        = string
  default     = "develop"
}

variable "project_name" {
  type        = string
  default     = "platform"
}

variable "vm_role" {
  type        =  list(string)
  default     =  ["web", "db"]
}