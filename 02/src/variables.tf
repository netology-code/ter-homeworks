# cloud vars

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


# ssh vars

variable "service_account_key_file" {
  type        = string
  description = "Путь к ключу яндекса"
}

variable "vms_ssh_public_root_key" {
  type        = string
  description = "Публичный ключ SSH для root-пользователя"
}

# name vars

variable "environment" {
  type    = string
  default = "env"
}

variable "role_web" {
  type    = string
  default = "web"
}

variable "role_db" {
  type    = string
  default = "db"
}

# new "test" var

variable "test" {
  description = "тестовая переменная для получения строки SSH подключения"
  type = list(
    map(
      list(string)
    )
  )
}
 
