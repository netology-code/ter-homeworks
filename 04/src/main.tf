resource "yandex_vpc_network" "develop" {
  name           = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a", "ru-central1-b"]
  subnet_ids     = [yandex_vpc_subnet.develop.id]
  instance_name  = "webs"
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner        = "gaidar_vu",
    project      = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [yandex_vpc_subnet.develop.id]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner= "gaidar_vu",
    project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "devops" {
  source         = "./vps"
  default_zone   = "ru-central1-a"
  default_cidr   = ["10.0.2.0/24"]
  vpc_name       = "net_dev"

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template       = file("./cloud-init.yml")
  vars           = {
    ssh_authorized_keys = var.vms_ssh_root_key
  }
}