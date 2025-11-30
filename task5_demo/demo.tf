terraform {
  required_version = ">= 1.6.0"
}

# Тест для строки без верхнего регистра
variable "lowercase_string" {
  type        = string
  description = "любая строка без символов верхнего регистра"
  default     = "hello world"

  validation {
    condition     = var.lowercase_string == lower(var.lowercase_string)
    error_message = "String must not contain uppercase characters."
  }
}

# Тест для объекта с исключающими значениями
variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    condition = (
      (var.in_the_end_there_can_be_only_one.Dunkan == true && var.in_the_end_there_can_be_only_one.Connor == false) ||
      (var.in_the_end_there_can_be_only_one.Dunkan == false && var.in_the_end_there_can_be_only_one.Connor == true)
    )
    error_message = "There can be only one MacLeod. One must be true and the other false."
  }
}

output "test" {
  value = "Task 5* validation test"
}
