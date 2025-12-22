resource "yandex_vpc_network" "network" {
  name = "${var.env_name}-network"
}

resource "yandex_vpc_subnet" "subnets" {
  count = length(var.subnets)

  name           = "${var.env_name}-subnet-${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
}
