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

variable "vm_web_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Зона доступности веб-ВМ"
}

### Переменные для БД-ВМ (vm_db_)

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Имя БД-виртуальной машины"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Платформа БД-ВМ"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "Количество ядер vCPU БД-ВМ"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Объем оперативной памяти в ГБ БД-ВМ"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "Гарантированная доля vCPU"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Прерываемая ли БД-ВМ"
}

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образа БД-ВМ"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "Зона доступности БД-ВМ"
}
