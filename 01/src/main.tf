terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=1.8.4" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {}

#однострочный комментарий

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx_container" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
/*
Ключ -auto-approve опасен тем, что автоматически подтверждает выполнение плана без запроса подтверждения от пользователя. Это может привести к:

Непреднамеренным изменениям - если план содержит ошибки или нежелательные изменения, они будут применены без возможности отмены

Потере данных - при удалении ресурсов или изменении критической инфраструктуры

Простоям сервисов - при замене работающих контейнеров или изменении конфигурации

Финансовым потерям - в облачных средах может создать ненужные ресурсы
*/
