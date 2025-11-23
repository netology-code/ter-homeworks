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

output "subnet_cidr_blocks" {
  description = "CIDR blocks of the created subnet"
  value       = yandex_vpc_subnet.subnet.v4_cidr_blocks
}
