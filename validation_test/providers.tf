terraform {
  required_version = ">= 1.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.92.0"
    }
  }
}

provider "yandex" {
  folder_id = "b1gokds3ue11292eobjh"
}
