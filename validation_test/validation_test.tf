# Минимальная конфигурация без бэкенда и провайдера
terraform {
  required_version = ">= 1.6.0"
}

# Валидация для одиночного IP-адреса
variable "ip_address" {
  type        = string
  description = "ip-адрес"
  default     = "192.168.0.1"

  validation {
    condition = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.ip_address))
    error_message = "Invalid IP address format."
  }
}

# Валидация для списка IP-адресов
variable "ip_list" {
  type        = list(string)
  description = "список ip-адресов"
  default     = ["1920.1680.0.1", "1.1.1.1", "127.0.0.1"]

  validation {
    condition = alltrue([
      for ip in var.ip_list : can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip))
    ])
    error_message = "One or more IP addresses in the list are invalid."
  }
}

# Простой output для тестирования
output "test_validation" {
  value = "IP validation test completed"
}
