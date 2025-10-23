# Глобальные переменные для всех стеков
globals {
  project     = "netology"
  environment = "null"
  region      = "ru-central1-a"
}

# Настройки Terraform
globals "terraform" {
  version = "~>1.12.0"
}

# Настройки backend
globals "terraform" "backend" {
  bucket = "netology-tfstate"
  region = "ru-central1"
}

