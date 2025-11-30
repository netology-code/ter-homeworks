# Минимальная конфигурация без бэкенда и провайдера для тестирования валидации

variable "test_ip" {
  type        = string
  description = "Test IP address for validation"
  default     = "192.168.1.1"

  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.test_ip))
    error_message = "Invalid IP address format."
  }
}

output "test_ip" {
  value = var.test_ip
}
