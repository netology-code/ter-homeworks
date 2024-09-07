terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = "~>1.9.5" /* Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {
  host     = "ssh://red0c@51.250.1.252:22"
}

#однострочный комментарий

resource "random_password" "admin" {
  length      = 8
  special     = false
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
}

resource "random_password" "user" {
  length      = 8
  special     = false
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = false
}

resource "docker_container" "db_mysql" {
  image = docker_image.mysql.image_id
  name  = "my_db"
  env = [
      "MYSQL_ROOT_PASSWORD=${random_password.admin.result}",
      "MYSQL_DATABASE=example",
      "MYSQL_USER=user",
      "MYSQL_PASSWORD=${random_password.user.result}",
      "MYSQL_ROOT_HOST=%"
  ]
  ports {
    internal = 3306
    #xternal = 9090
  }
}
