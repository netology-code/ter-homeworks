variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "network"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "subnet"
}

variable "subnets" {
    description = "subnets"
    type        = list(object({zone = string, cidr = string}))
    default     = [
        {zone = "ru-central1-a", cidr = "10.0.1.0/24"},
        {zone = "ru-central1-b", cidr = "10.0.2.0/24"},
        {zone = "ru-central1-d", cidr = "10.0.3.0/24"}
    ]   
}