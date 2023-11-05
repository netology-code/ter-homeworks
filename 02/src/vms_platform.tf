
variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "server-type"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "server-type"
}

# VM web resources
variable "vm_web_resources" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

# VM db resources
variable "vm_db_resources" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

