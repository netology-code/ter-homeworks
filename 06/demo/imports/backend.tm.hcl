# Генерация конфигурации backend для каждого стека
generate_hcl "_backend.tf" {
  condition = global.environment != "null"
  
  content {
    terraform {
      backend "s3" {
        bucket  = global.terraform.backend.bucket
        key     = "${terramate.stack.path.relative}/terraform.tfstate"
        region  = global.terraform.backend.region
        
        # Встроенные блокировки
        use_lockfile = true
        
        endpoints = {
          s3 = "https://storage.yandexcloud.net"
        }
        
        skip_region_validation      = true
        skip_credentials_validation = true
        skip_requesting_account_id  = true
        skip_s3_checksum            = true
      }
    }
  }
}

