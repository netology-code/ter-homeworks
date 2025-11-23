# modules/vpc/main.tf

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.171.0"
    }
  }
}

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

resource "yandex_vpc_network" "network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "subnet" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.cidr_blocks]
}
