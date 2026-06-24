# создаем облачную сеть
#resource "yandex_vpc_network" "develop" {
#  name = "develop"
#}

# создаем подсеть
#resource "yandex_vpc_subnet" "develop_a" {
#  name           = "develop-ru-central1-a"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.1.0/24"]
#}

#resource "yandex_vpc_subnet" "develop_b" {
#  name           = "develop-ru-central1-b"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.2.0/24"]
#}

module "vpc_dev" {
  source   = "./vpc"
  env_name = "develop"
  zone     = "ru-central1-a"
  cidr     = "10.0.1.0/24"
}

module "marketing_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"

  env_name       = "marketing"
  #network_id     = yandex_vpc_network.develop.id
  network_id = module.vpc_dev.subnet.network_id
  subnet_zones   = ["ru-central1-a"]
  #subnet_ids     = [yandex_vpc_subnet.develop_a.id]
  subnet_ids = [module.vpc_dev.subnet.id]
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "marketing"
  }

  metadata = {
    user-data = local.cloudinit
    serial-port-enable = 1
  }
}

module "analytics_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"

  env_name       = "analytics"
  #network_id     = yandex_vpc_network.develop.id
  network_id = module.vpc_dev.subnet.network_id
  subnet_zones = ["ru-central1-a"]
  #subnet_ids     = [yandex_vpc_subnet.develop_b.id]
  subnet_ids = [module.vpc_dev.subnet.id]
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "analytics"
  }

  metadata = {
    user-data = local.cloudinit
    serial-port-enable = 1
  }
}

locals {
  cloudinit = templatefile("${path.module}/cloud-init.yml", {
    ssh_public_keys = join("\n      - ", var.public_keys)
  })
}
