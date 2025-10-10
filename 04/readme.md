#### Домашняя работа terrafrom 04

## Задание 1

sudo nginx:  
![alt text](image-2.png)  
![alt text](image-3.png)

console cloud:  
![alt text](image-1.png)

terraform output:  
![alt text](image.png)

## Задание 2

## Задание 3

terraform state list:  
![alt text](image-4.png)

terraform state rm 'module.vpc_develop':  
![alt text](image-5.png)

terraform state rm 'module.marketing-vm', terraform state rm 'module.analytics-vm':  
![alt text](image-6.png)

import vpc modules:  
![alt text](image-7.png)  

import vm instances:  
![alt text](image-8.png)  
![alt text](image-9.png)  

terraform plan:  
![alt text](image-10.png)


## Задание 4

Результат terraform plan:

часть вывода с vpc (в яндекс нет зоны ru-central1-с, apply вываливался с ошибкой. Заменил на ru-central1-d):  
![alt text](image-11.png)

Для передачи id в инстансы vm заведен output в модуле vpc

## Задание 5

кластер с 2 хостами:

```hcl
module "mysql-managed" {
    source = "./modules/mysql"
    cluster_name = "example"
    network_id = module.vpc_develop.network.id
    subnet_ids = module.vpc_develop.subnet_ids
    HA = true
}
```

![alt text](image-14.png)

кластер с 1 хостом:

```hcl
module "mysql-managed" {
    source = "./modules/mysql"
    cluster_name = "example"
    network_id = module.vpc_develop.network.id
    subnet_ids = module.vpc_develop.subnet_ids
    HA = false
}
```

![alt text](image-13.png)

ресурсы db и user:
![alt text](image-15.png)

Вывод из cli yandex cloud:
![alt text](image-17.png)

Два хоста:
![alt text](image-18.png)

## Задание 6

## Задание 7

секрет из vault:  
![alt text](image-12.png)

сектрет записал:  

```hcl
resource "vault_generic_secret" "vault_my_example"{
 path = "secret/my_example"

 data_json = jsonencode({
    username = "admin"
    password = var.mysql_db_user_password
  })
}
```

![alt text](image-16.png)

## Задание 8
