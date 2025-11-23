terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.171.0"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

# VPC Resources
resource "yandex_vpc_network" "vpc_prod" {
  name = "vpc-prod"
}

resource "yandex_vpc_subnet" "vpc_prod_subnets" {
  count          = 3
  name           = "prod-subnet-${count.index}"
  zone           = element(["ru-central1-a", "ru-central1-b", "ru-central1-c"], count.index)
  network_id     = yandex_vpc_network.vpc_prod.id
  v4_cidr_blocks = [element(["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], count.index)]
}

resource "yandex_vpc_network" "vpc_dev" {
  name = "vpc-dev"
}

resource "yandex_vpc_subnet" "vpc_dev_subnets" {
  name           = "dev-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_dev.id
  v4_cidr_blocks = ["10.10.1.0/24"]
}

# Compute Instances (минимальная конфигурация для проверки)
resource "yandex_compute_instance" "marketing_vm" {
  name        = "marketing-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.vpc_dev_subnets.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "analytics_vm" {
  name        = "analytics-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.vpc_prod_subnets[0].id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# Modules
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.10.1.0/24" }
  ]
}

module "vpc_prod" {
  source   = "./modules/vpc"
  env_name = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" }
  ]
}

module "mysql_example_single" {
  source = "./modules/mysql-cluster"
  # Добавьте необходимые параметры
}

module "example_database" {
  source = "./modules/mysql-database"
  # Добавьте необходимые параметры
}

module "mysql_example_ha" {
  source = "./modules/mysql-cluster"
  # Добавьте необходимые параметры
}

module "example_ha_database" {
  source = "./modules/mysql-database"
  # Добавьте необходимые параметры
}
