terramate {
  config {
  }
}

globals {
  # Общие настройки Yandex Cloud для всех окружений
  yc_cloud_id  = "b1gn3ndpua1j6jaabf79"
  yc_folder_id = "b1gfu61oc15cb99nqmfe"
  yc_zone      = "ru-central1-a"
  
  # Путь к ключу авторизации
  yc_key_file = "~/.authorized_key.json"
  
  # Terraform версия
  terraform_version = "~>1.12.0"
}

