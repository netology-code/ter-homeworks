module "vpc-dev" {
  source       = "./vpc-dev"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
     labels = { 
     project = "marketing"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }
}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
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

# data "template_file" "cloudinit" {
#   template = file("./cloud-init.yml")
#    vars = {
#      ssh_public_key = var.ssh_public_key
#    }
# }


data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
   vars = {
     ssh_public_key = var.ssh_public_key
   }
}
