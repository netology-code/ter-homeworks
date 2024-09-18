output "vpc_network_id" {
    value = yandex_vpc_network.develop.id
}
/*output "vpc_netwrok_subnet_id" {
    value = yandex_vpc_subnet.develop.id
    depends_on = [ yandex_vpc_network.develop ]
}*/
output "vpc_netwrok_subnets_id" {
    value = [for i in yandex_vpc_subnet.develop: i.id]
    depends_on = [ yandex_vpc_network.develop ]
}