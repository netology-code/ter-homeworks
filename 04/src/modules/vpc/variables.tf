variable "env_name" {
  type        = string
  description = "Environment name"
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "List of subnets to create in different availability zones"
}
