module "marketing_vm" {
  source         = "git::https://github.com/x0r1x/yandex_compute_instance.git?ref=main"
  env_name       = var.vms.marketing.env_name
  network_id     = module.vpc_dev.vpc_network_id
  subnet_zones   = [var.default_zone]
  #subnet_ids     = #[module.vpc.vpc_netwrok_subnet_id]
  subnet_ids     = module.vpc_dev.vpc_netwrok_subnets_id
  instance_name  = var.vms.marketing.instance_name
  instance_count = var.vms.marketing.instance_count
  image_family   = var.vms.marketing.image_family
  public_ip      = var.vms.marketing.public_ip 

  labels = { 
    project = var.vms.marketing.env_name
  }

  metadata = {
    #user-data          = data.template_file.cloudinit.rendered 
    user-data          = local.cloudinit
  }

}

module "analytic_vm" {
  source         = "git::https://github.com/x0r1x/yandex_compute_instance.git?ref=main"
  env_name       = var.vms.analytic.env_name
  network_id     = module.vpc_dev.vpc_network_id
  subnet_zones   = [var.default_zone]
  #subnet_ids     = [module.vpc.vpc_netwrok_subnet_id]
  subnet_ids     = module.vpc_dev.vpc_netwrok_subnets_id
  instance_name  = var.vms.analytic.instance_name
  instance_count = var.vms.analytic.instance_count
  image_family   = var.vms.analytic.image_family
  public_ip      = var.vms.analytic.public_ip

  labels = { 
    project = var.vms.analytic.env_name
  }

  metadata = {
    #user-data          = data.template_file.cloudinit.rendered 
    user-data          = local.cloudinit
  }

}

/*data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    ssh_public_key = local.ssh_pub_key
  }
}*/