terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── versions.tf
├── templates/
│ └── cloud-init.yml
├── modules/
│ ├── vpc/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ │ └── README.md
│ ├── marketing_vm/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ ├── mysql-cluster/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ └── mysql-database/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
└── README.md

## ✅ Задание 1 - Модули для ВМ

### Выполненные действия:

1. **Создан модуль marketing_vm** в `modules/marketing_vm/`
2. **Настроен cloud-init.yml** с переменной для SSH-ключа
3. **Добавлена установка nginx** в cloud-init конфигурацию
4. **Проверено подключение** и работа nginx на ВМ

### Код модуля marketing_vm:

**modules/marketing_vm/main.tf:**

resource "yandex_compute_instance" "marketing_vm" {
  name        = "marketing-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd84nt41ssoaapgql97p" # Ubuntu 22.04
      size     = 20
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
    user-data = templatefile("${path.module}/../../templates/cloud-init.yml", {
      ssh_public_key = var.ssh_public_key
      vm_project     = "marketing"
    })
  }

  labels = {
    environment = "marketing"
    owner       = "marketing-team"
    project     = "terraform"
  }
}
modules/marketing_vm/variables.tf:


variable "subnet_id" {
  description = "Subnet ID for the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}
modules/marketing_vm/outputs.tf:


output "external_ip" {
  description = "External IP address of the VM"
  value       = yandex_compute_instance.marketing_vm.network_interface[0].nat_ip_address
}

output "internal_ip" {
  description = "Internal IP address of the VM"
  value       = yandex_compute_instance.marketing_vm.network_interface[0].ip_address
}

output "name" {
  description = "VM name"
  value       = yandex_compute_instance.marketing_vm.name
}

output "instance_id" {
  description = "VM instance ID"
  value       = yandex_compute_instance.marketing_vm.id
}

output "labels" {
  description = "VM labels"
  value       = yandex_compute_instance.marketing_vm.labels
}
Cloud-init конфигурация:
templates/cloud-init.yml:

yaml
#cloud-config
users:
  - name: ubuntu
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ${ssh_public_key}

package_update: true
package_upgrade: true

packages:
  - nginx

runcmd:
  - systemctl enable nginx
  - systemctl start nginx
  - ufw allow 'Nginx HTTP'
  - echo "Cloud-init completed successfully for ${vm_project}" > /etc/motd
Результаты выполнения:
✅ Успешное подключение к ВМ по SSH
✅ Nginx установлен и запущен
✅ Проверка конфигурации: sudo nginx -t - успешно
✅ Метки ВМ отображаются в Yandex Cloud Console
✅ Модуль доступен через terraform console


✅ Задание 2 - Модуль VPC
Создан модуль VPC:
modules/vpc/main.tf:

resource "yandex_vpc_network" "network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "subnet" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.cidr_blocks]
}
modules/vpc/variables.tf:

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "vpc-network"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "vpc-subnet"
}

variable "zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "cidr_blocks" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "192.168.10.0/24"
}
modules/vpc/outputs.tf:

output "network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.network.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = yandex_vpc_subnet.subnet.id
}

output "network_name" {
  description = "Name of the created VPC network"
  value       = yandex_vpc_network.network.name
}

output "subnet_cidr_blocks" {
  description = "CIDR blocks of the created subnet"
  value       = yandex_vpc_subnet.subnet.v4_cidr_blocks
}

output "subnet_info" {
  description = "Complete information about the subnet"
  value = {
    id           = yandex_vpc_subnet.subnet.id
    name         = yandex_vpc_subnet.subnet.name
    zone         = yandex_vpc_subnet.subnet.zone
    network_id   = yandex_vpc_subnet.subnet.network_id
    v4_cidr_blocks = yandex_vpc_subnet.subnet.v4_cidr_blocks
  }
}
Основная конфигурация:
main.tf:

terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.171.0"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

# Модуль VPC
module "vpc" {
  source = "./modules/vpc"

  network_name = "terraform-network"
  subnet_name  = "terraform-subnet"
  zone         = "ru-central1-a"
  cidr_blocks  = "192.168.100.0/24"
}

# Модуль marketing_vm
module "marketing_vm" {
  source = "./modules/marketing_vm"

  subnet_id      = module.vpc.subnet_id
  ssh_public_key = var.vms_ssh_root_key
  zone           = "ru-central1-a"
}

# Ресурс analytics_vm
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
      image_id = "fd84nt41ssoaapgql97p"
      size     = 20
    }
  }

  network_interface {
    subnet_id = module.vpc.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  }

  labels = {
    environment = "analytics"
    owner       = "analytics-team"
    project     = "terraform"
  }
}
Документация с terraform-docs:
modules/vpc/README.md:

markdown
## VPC Module

### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| yandex | >= 0.171.0 |

### Providers

| Name | Version |
|------|---------|
| yandex | >= 0.171.0 |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr_blocks | CIDR block for the subnet | `string` | `"192.168.10.0/24"` | no |
| network_name | Name of the VPC network | `string` | `"vpc-network"` | no |
| subnet_name | Name of the subnet | `string` | `"vpc-subnet"` | no |
| zone | Availability zone for the subnet | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| network_id | ID of the created VPC network |
| network_name | Name of the created VPC network |
| subnet_cidr_blocks | CIDR blocks of the created subnet |
| subnet_id | ID of the created subnet |
| subnet_info | Complete information about the subnet |
✅ Задание 3 - Операции со state
Выполненные команды:

# 1. Вывод списка ресурсов в стейте
terraform state list

# Результат:
# module.marketing_vm.yandex_compute_instance.marketing_vm
# module.vpc.yandex_vpc_network.network
# module.vpc.yandex_vpc_subnet.subnet
# yandex_compute_instance.analytics_vm

# 2. Удаление модуля VPC из стейта
terraform state rm module.vpc

# 3. Удаление модуля VM из стейта
terraform state rm module.marketing_vm
terraform state rm yandex_compute_instance.analytics_vm

# 4. Импорт ресурсов обратно
# Получение ID ресурсов
yc vpc network list
yc vpc subnet list
yc compute instance list

# Импорт VPC сети
terraform import module.vpc.yandex_vpc_network.network enp8he3d37dhk5tnvjri

# Импорт подсети
terraform import module.vpc.yandex_vpc_subnet.subnet e9bjp84lpfvg2ls15dub

# Импорт marketing VM
terraform import module.marketing_vm.yandex_compute_instance.marketing_vm fhm0qeo8sblurjj868c4

# Импорт analytics VM
terraform import yandex_compute_instance.analytics_vm fhmuor61p09homf0v7tg

# 5. Проверка отсутствия изменений
terraform plan
Результат:
✅ Все ресурсы успешно удалены из стейта
✅ Все ресурсы успешно импортированы обратно
✅ terraform plan показывает "No changes" - значимых изменений нет

⭐ Задание 4* - Расширенный модуль VPC
Модифицированный модуль VPC:
modules/vpc/variables.tf (обновленный):

variable "env_name" {
  type        = string
  description = "Environment name"
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "List of subnets to create in different availability zones"
}
modules/vpc/main.tf (обновленный):

resource "yandex_vpc_network" "network" {
  name = "${var.env_name}-network"
}

resource "yandex_vpc_subnet" "subnets" {
  count = length(var.subnets)

  name           = "${var.env_name}-subnet-${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
}
modules/vpc/outputs.tf (обновленный):

output "network_id" {
  value = yandex_vpc_network.network.id
}

output "network_name" {
  value = yandex_vpc_network.network.name
}

output "subnet_ids" {
  value = { for idx, subnet in yandex_vpc_subnet.subnets : var.subnets[idx].zone => subnet.id }
}

output "subnets" {
  value = { for idx, subnet in yandex_vpc_subnet.subnets : var.subnets[idx].zone => {
    id             = subnet.id
    name           = subnet.name
    zone           = subnet.zone
    v4_cidr_blocks = subnet.v4_cidr_blocks
  } }
}
Пример использования:

# Production VPC с подсетями во всех зонах
module "vpc_prod" {
  source   = "./modules/vpc"
  env_name = "production"

  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

# Development VPC с одной подсетью
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"

  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
⭐ Задание 5* - Модуль Managed MySQL
Модуль MySQL кластера:
modules/mysql-cluster/main.tf:

resource "yandex_mdb_mysql_cluster" "cluster" {
  name        = var.cluster_name
  environment = "PRODUCTION"
  network_id  = var.network_id

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  database {
    name = var.database_name
  }

  user {
    name     = var.user_name
    password = var.user_password
    
    permission {
      database_name = var.database_name
      roles         = ["ALL"]
    }
  }

  host {
    zone      = var.zone
    subnet_id = var.subnet_id
  }

  dynamic "host" {
    for_each = var.ha_enabled ? [1] : []
    content {
      zone      = var.ha_zone
      subnet_id = var.ha_subnet_id
    }
  }
}
modules/mysql-cluster/variables.tf:

variable "cluster_name" {
  description = "MySQL cluster name"
  type        = string
}

variable "network_id" {
  description = "Network ID for the cluster"
  type        = string
}

variable "database_name" {
  description = "Database name"
  type        = string
  default     = "default_db"
}

variable "user_name" {
  description = "Database user name"
  type        = string
  default     = "default_user"
}

variable "user_password" {
  description = "Database user password"
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "Primary availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "ha_enabled" {
  description = "Enable High Availability"
  type        = bool
  default     = false
}

variable "ha_zone" {
  description = "HA availability zone"
  type        = string
  default     = "ru-central1-b"
}

variable "subnet_id" {
  description = "Primary subnet ID"
  type        = string
}

variable "ha_subnet_id" {
  description = "HA subnet ID"
  type        = string
  default     = ""
}
Модуль MySQL базы данных:
modules/mysql-database/main.tf:

resource "yandex_mdb_mysql_database" "database" {
  cluster_id = var.cluster_id
  name       = var.database_name
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = var.cluster_id
  name       = var.user_name
  password   = var.user_password

  permission {
    database_name = yandex_mdb_mysql_database.database.name
    roles         = var.user_roles
  }
}
modules/mysql-database/variables.tf:

hcl
variable "cluster_id" {
  description = "MySQL cluster ID"
  type        = string
}

variable "database_name" {
  description = "Database name to create"
  type        = string
}

variable "user_name" {
  description = "User name to create"
  type        = string
}

variable "user_password" {
  description = "User password"
  type        = string
  sensitive   = true
}

variable "user_roles" {
  description = "User roles for the database"
  type        = list(string)
  default     = ["ALL"]
}
Пример использования:

# Single-host кластер
module "mysql_single" {
  source       = "./modules/mysql-cluster"
  cluster_name = "example-single"
  network_id   = module.vpc.network_id
  subnet_id    = module.vpc.subnet_ids["ru-central1-a"]
  database_name = "test"
  user_name     = "app"
  user_password = "securepassword123"
  ha_enabled    = false
}

# Multi-host кластер
module "mysql_ha" {
  source        = "./modules/mysql-cluster"
  cluster_name  = "example-ha"
  network_id    = module.vpc_prod.network_id
  subnet_id     = module.vpc_prod.subnet_ids["ru-central1-a"]
  ha_subnet_id  = module.vpc_prod.subnet_ids["ru-central1-b"]
  database_name = "test"
  user_name     = "app"
  user_password = "securepassword123"
  ha_enabled    = true
}
🚀 Дополнительные задания
Задание 6* - S3 Bucket
hcl
module "s3_bucket" {
  source = "terraform-yc-modules/s3-bucket/yandex"
  
  bucket = "my-terraform-bucket-12345"
  acl    = "private"
  
  versioning = {
    enabled = true
  }
}

Задание 7* - Vault Integration
provider "vault" {
  address          = "http://127.0.0.1:8200"
  skip_tls_verify  = true
  token            = "education"
}

data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

# Запись секрета в Vault
resource "vault_generic_secret" "example" {
  path = "secret/terraform"

  data_json = jsonencode({
    username = "admin"
    password = "supersecret"
  })
}

📊 Результаты выполнения
Проверочные команды:

# Инициализация
terraform init

# Проверка синтаксиса
terraform validate

# Планирование
terraform plan

# Применение
terraform apply -auto-approve

# Проверка состояния
terraform state list

# Уничтожение ресурсов
terraform destroy -auto-approve
Критерии выполнения:
✅ Все задания выполнены
✅ Код следует best practices
✅ Модули переиспользуемы
✅ Документация сгенерирована
✅ State операции отработаны корректно
✅ Ресурсы созданы и уничтожены

Ссылка на репозиторий: https://github.com/sapr797/ter-homeworks/tree/terraform-04
Ветка: terraform-04


