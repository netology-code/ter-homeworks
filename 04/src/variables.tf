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
  description = "VPC network&subnet name"
}

###common vars

/*variable "vms_ssh_root_key" {
  type        = string
  default     = "your_ssh_ed25519_key"
  description = "ssh-keygen -t ed25519"
}*/

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}

variable "vms" {
  type = map(object({
    env_name  = string
    instance_name = string
    instance_count = number
    image_family = string
    public_ip = bool
    serial-port-enable = number
  }))
  default = {
    "marketing" = {
      env_name = "marketing"
      instance_name = "web"
      instance_count = 1
      image_family = "ubuntu-2004-lts"
      public_ip = true
      serial-port-enable = 1
    },
    "analytic" = {
      env_name = "analytic"
      instance_name = "web"
      instance_count = 1
      image_family = "ubuntu-2004-lts"
      public_ip = true
      serial-port-enable = 1
    }
  }
}

variable "s3_dev_mod" {
  type = object({
    bucket_name = string
    max_size = number
  })
  default = {
    bucket_name = "bender-dev-bucket"
    max_size = 1024 * 1024 * 1024 # 1GB 
  }
}
