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

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "yandex compute instance name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1" #standart-v4 error
  description = "yandex compute instance platform id"
}

variable "vm_web_resources_cores" {
  type        = number
  default     = 1
  description = "yandex compute instance cores number"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdYmU9HIi9D5Ca76K2FhkgXilzCCBx+JEDgeCpQjjP2 decimal@DESKTOP-LLH62I7"
  description = "ssh-keygen -t ed25519"
}
