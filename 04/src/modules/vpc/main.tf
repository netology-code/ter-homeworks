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

# Создание подсетей в разных зонах доступности
resource "yandex_vpc_subnet" "subnets" {
  count = length(var.subnets)

  name           = "${var.env_name}-subnet-${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
}
