terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}


resource "yandex_vpc_network" "network" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "subnet" {
  name = "${var.env_name}-${var.zone}"
  zone = var.zone
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = var.cidr_block
}