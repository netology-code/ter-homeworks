variable "env_name" {
  type        = string
  description = "VPC network & subnet name"
}

variable "zone" {
  type        = string
  description = "Availability zone for the subnet"
}

variable "cidr" {
  type        = string
  description = "CIDR block for the subnet"
}