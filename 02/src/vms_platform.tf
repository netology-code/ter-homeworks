
variable "vm_web_instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "vm_name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "server-type"
}

variable "vm_db_instance_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "vm_name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "server-type"
}

