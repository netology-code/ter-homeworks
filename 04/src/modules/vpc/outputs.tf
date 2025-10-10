output "subnet" {
    description = "subnet info"
    value = "${yandex_vpc_subnet.subnet}"
}

output "network" {
    description = "network info"
    value = "${yandex_vpc_network.network}"
}

#для использования id в ресурсах
output "subnet_ids" {
    value = {for i, subnet in yandex_vpc_subnet.subnet: var.subnets[i].zone => subnet.id}
}