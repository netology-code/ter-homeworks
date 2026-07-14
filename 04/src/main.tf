module "vpc_dev" {
  source   = "./vpc"
  env_name = var.vpc_name
  zone     = var.default_zone
  cidr     = var.default_cidr[0]
}

locals {
  ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    ssh_key = local.ssh_key
  }
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=de7090ae115ee5059cd81053a808af079c325e01"
  env_name       = "develop"
  network_id     = module.vpc_dev.subnet.network_id
  subnet_zones   = [module.vpc_dev.subnet.zone]
  subnet_ids     = [module.vpc_dev.subnet.id]
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = false

  labels = {
    project = "marketing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=de7090ae115ee5059cd81053a808af079c325e01"
  env_name       = "develop"
  network_id     = module.vpc_dev.subnet.network_id
  subnet_zones   = [module.vpc_dev.subnet.zone]
  subnet_ids     = [module.vpc_dev.subnet.id]
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}