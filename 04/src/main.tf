module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc_develop.network.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_develop.subnet_ids["ru-central1-a"]]
  instance_count = 1
  instance_name  = "marketing-vm"
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner= "kolmykov",
    project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc_develop.network.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_develop.subnet_ids["ru-central1-a"]]
  instance_count = 1
  instance_name  = "analytics-vm"
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner= "kolmykov",
    project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  
  template = local.template_file

  vars = {
    ssh_key = local.ssh_key
  }
}

module "mysql-managed" {
    source = "./modules/mysql"
    cluster_name = "example"
    network_id = module.vpc_develop.network.id
    subnet_ids = module.vpc_develop.subnet_ids
    HA = true
}

module "mysql_db" {
  source          = "./modules/db-user"

  cluster_id      = module.mysql-managed.cluster_id
  database_name   = "test"
  user_name       = "app"
  user_password   = var.mysql_db_user_password

  user_permissions = ["test"]
}

provider "vault" {
 address = "http://127.0.0.1:8200"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

resource "vault_generic_secret" "vault_my_example"{
 path = "secret/my_example"

 data_json = jsonencode({
    username = "admin"
    password = var.mysql_db_user_password
  })
}


