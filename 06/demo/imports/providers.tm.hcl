# Генерация конфигурации провайдеров
generate_hcl "_providers.tf" {
  condition = global.environment != "null"
  
  content {
    terraform {
      required_version = global.terraform.version
      
      required_providers {
        random = {
          source  = "hashicorp/random"
          version = "~> 3.6.0"
        }
      }
    }
    
    provider "random" {}
  }
}

