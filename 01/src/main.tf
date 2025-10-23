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

provider "docker" {
  host = "ssh://wqtr@89.169.167.232:22"
}

resource "random_password" "mysql_root" {
  length  = 16
  upper   = true
  lower   = true
  numeric  = true
  special = false
}

resource "random_password" "mysql_user" {
  length  = 16
  upper   = true
  lower   = true
  numeric  = true
  special = false
}

resource "docker_container" "mysql" {
  image = "mysql:8"
  name  = "example_${random_password.mysql_root.result}"

  ports {
    internal = 3306
    external = 3306
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user.result}",
    "MYSQL_ROOT_HOST=%"
  ]
}

