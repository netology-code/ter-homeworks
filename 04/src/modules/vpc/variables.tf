# modules/vpc/variables.tf

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "vpc-network"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "vpc-subnet"
}

variable "zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "cidr_blocks" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "192.168.10.0/24"
}
