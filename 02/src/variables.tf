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


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

### Переменные для ВМ (vm_web_)

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Имя виртуальной машины"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Платформа виртуальной машины"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "Количество ядер vCPU"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Объем оперативной памяти в ГБ"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 20
  description = "Гарантированная доля vCPU"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Флаг прерываемой виртуальной машины"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образов для ВМ"
}
