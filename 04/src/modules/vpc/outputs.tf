output "network_id" {
  value = yandex_vpc_network.network.id
}

output "network_name" {
  value = yandex_vpc_network.network.name
}

output "subnet_ids" {
  value = { for idx, subnet in yandex_vpc_subnet.subnets : var.subnets[idx].zone => subnet.id }
}

output "subnets" {
  value = { for idx, subnet in yandex_vpc_subnet.subnets : var.subnets[idx].zone => {
    id             = subnet.id
    name           = subnet.name
    zone           = subnet.zone
    v4_cidr_blocks = subnet.v4_cidr_blocks
  } }
}
