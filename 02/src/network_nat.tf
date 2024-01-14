#data "yandex_vpc_network" "net" {
#  folder_id = var.folder_id
#  name      = var.vpc_name
#}

resource "yandex_vpc_subnet" "nat" {
  folder_id      = var.folder_id
  name           = var.vpc_name
  v4_cidr_blocks = var.default_cidr
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = var.test_nat_gateway
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = var.route_table_name
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}