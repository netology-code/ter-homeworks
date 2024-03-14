output "vpc_network"{
  value       = yandex_vpc_network.network
  description = "Yandex vpc network"
}
output "vpc_subnet"{
  value       = yandex_vpc_subnet.subnet
  description = "Yandex vpc subnet"
}

