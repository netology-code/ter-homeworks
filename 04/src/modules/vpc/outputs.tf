# modules/vpc/outputs.tf

output "network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.network.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = yandex_vpc_subnet.subnet.id
}

output "network_name" {
  description = "Name of the created VPC network"
  value       = yandex_vpc_network.network.name
}

output "subnet_name" {
  description = "Name of the created subnet"
  value       = yandex_vpc_subnet.subnet.name
}

output "subnet_cidr_blocks" {
  description = "CIDR blocks of the created subnet"
  value       = yandex_vpc_subnet.subnet.v4_cidr_blocks
}

output "zone" {
  description = "Availability zone of the subnet"
  value       = yandex_vpc_subnet.subnet.zone
}

# Полная информация о подсети
output "subnet_info" {
  description = "Complete information about the subnet"
  value = {
    id           = yandex_vpc_subnet.subnet.id
    name         = yandex_vpc_subnet.subnet.name
    zone         = yandex_vpc_subnet.subnet.zone
    network_id   = yandex_vpc_subnet.subnet.network_id
    v4_cidr_blocks = yandex_vpc_subnet.subnet.v4_cidr_blocks
    created_at   = yandex_vpc_subnet.subnet.created_at
  }
}

# Полная информация о сети
output "network_info" {
  description = "Complete information about the network"
  value = {
    id      = yandex_vpc_network.network.id
    name    = yandex_vpc_network.network.name
    created_at = yandex_vpc_network.network.created_at
  }
}
