variable "env_name" {
  type        = string
  description = "VPC network&subnet name"
}

variable "cidr_block"{
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "zone"{
  type        = string
  default     = ""
}
