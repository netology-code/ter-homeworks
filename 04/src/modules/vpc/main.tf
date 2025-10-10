terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_vpc_network" "network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "subnet" {

  count = length(var.subnets)

  name           = "${var.subnet_name}-${count.index + 1}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]

}

# module "s3" {
#   source = "github.com/terraform-yc-modules/terraform-yc-s3"

#   bucket_name = "bucket-netology-ter-05-decimal"
#   versioning = {
#     enabled = true
#   }
# }