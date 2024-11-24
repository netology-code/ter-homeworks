###cloud vars
variable "token" {
  type        = string
}

variable "cloud_id" {
  type        = string
}

variable "folder_id" {
  type        = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###common vars

variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

### Проверка IP адресов

variable "ip_addr" {
  type=string
  description="ip-адрес"
  default="192.168.0.1"
  validation {
    condition = can(cidrhost("${var.ip_addr}/32", 0))
    error_message = "Wrong IP"
  }
}

variable "ip_addrs" {
  type=list(string)
  description="список ip-адресов"
  default=["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  validation {
    condition = alltrue([ for ip_addr in var.ip_addrs: can(cidrhost("${ip_addr}/32", 0)) ])
    error_message = "There are wrong IP's in a list"
  }
}

variable "ip_addr_regex" {
  type=string
  description="ip-адрес"
  default="192.168.0.1"
  validation {
    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.ip_addr_regex))
    error_message = "IP is incorrect"
  }
}