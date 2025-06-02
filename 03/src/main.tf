resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
#  default_security_group_id = "enplpecm6j76s7feq4s5" 
#  security_group_id = "enplpecm6j76s7feq4s5" 
#  security_group_id = "example_dynamic"  # Указываем групп безопасности  
#network_id = yandex_vpc_network.develop.id
#  security_group_id = "var.yandex_vpc_security_group"
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
# #security_group_id = "enplpecm6j76s7feq4s5"  # Указываем групп безопасности  
}


#создаем облачную сеть
#resource "yandex_vpc_network" "develop" {
#  name = "develop"
#}

#создаем подсеть
#resource "yandex_vpc_subnet" "develop" {
#  name           = "develop-ru-central1-a"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.1.0/24"]
#}