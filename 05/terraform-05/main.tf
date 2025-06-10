# #создаем облачную сеть
# resource "yandex_vpc_network" "develop" {
#   name = "develop"
# }

# #создаем подсеть
# resource "yandex_vpc_subnet" "develop_a" {
#   name           = "develop-ru-central1-a"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = ["10.0.1.0/24"]
# }!!!!!!!!!!!!!!!!!!nnenenenwe!!!!!!!!!!!!!!!!!!!!!!!

module "vpc-dev" {
  source       = "./vpc-dev"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id     = module.vpc-dev.network_id 
#  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.vpc-dev.subnet_id] #,yandex_vpc_subnet.develop_b.id
  #subnet_ids     = [yandex_vpc_subnet.develop_a.id] #,yandex_vpc_subnet.develop_b.id
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  

   labels = { 
  #   owner= "i.ivanov",
     project = "marketing"
      }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id     = module.vpc-dev.network_id 
 # network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
#  subnet_ids     = [yandex_vpc_subnet.develop_a.id]
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true


   labels = { 
  #   owner= "i.ivanov",
     project = "analytics"
      }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ.(передали путь к yml файлу и переменную!_ssh_public_key)
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
   vars = {
     ssh_public_key = var.ssh_public_key
   }
}

