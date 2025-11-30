#!/bin/bash

# Скрипт для настройки credentials в модулях

SECRET_KEY=$(terraform -chdir=06-s3-bucket output -raw secret_key 2>/dev/null || echo "YOUR_SECRET_KEY_HERE")

# Функция для замены credentials в файлах
replace_credentials() {
    local file=$1
    sed -i "s|YCAJE9v1zXNMiZAKk0b77Gx3i|$(terraform -chdir=06-s3-bucket output -raw access_key 2>/dev/null)|g" "$file"
    sed -i "s|YCPM2JXbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|$SECRET_KEY|g" "$file"
    sed -i "s|tf-homework-b1gokds3ue11292eobjh-001|$(terraform -chdir=06-s3-bucket output s3_bucket_name 2>/dev/null)|g" "$file"
}

echo "Setting up credentials in modules..."

# Заменяем credentials в VPC модуле
replace_credentials "vpc_module/main.tf"
replace_credentials "vpc_module/outputs.tf"

# Заменяем credentials в VM модуле  
replace_credentials "vm_module/main.tf"
replace_credentials "vm_module/outputs.tf"

echo "Credentials updated successfully!"
