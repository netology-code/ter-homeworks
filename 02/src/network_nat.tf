#data "yandex_vpc_network" "net" {
#  folder_id = var.folder_id
#  name      = var.vpc_name
#}

#WEB
resource "yandex_vpc_subnet" "nat_web" {
  folder_id      = var.folder_id
  name           = var.vpc_name
  v4_cidr_blocks = var.default_cidr
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.rt_web.id
}

resource "yandex_vpc_gateway" "nat_gateway_web" {
  name = var.test_nat_gateway_web
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt_web" {
  name       = var.route_table_name_web
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway_web.id
  }
}

#DB
#resource "yandex_vpc_subnet" "nat_db" {
#  folder_id      = var.folder_id
#  name           = var.vpc_name_2
#  v4_cidr_blocks = var.default_cidr
#  zone           = var.zone_b
#  network_id     = yandex_vpc_network.develop-2.id
#  route_table_id = yandex_vpc_route_table.rt_db.id
#}
#
#resource "yandex_vpc_gateway" "nat_gateway_db" {
#  name = var.test_nat_gateway_DB
#  shared_egress_gateway {}
#}
#
#resource "yandex_vpc_route_table" "rt_db" {
#  name       = var.route_table_name_DB
#  network_id = yandex_vpc_network.develop-2.id
#
#  static_route {
#    destination_prefix = "0.0.0.0/0"
#    gateway_id         = yandex_vpc_gateway.nat_gateway_db.id
#  }
#}