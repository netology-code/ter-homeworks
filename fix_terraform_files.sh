#!/bin/bash
echo "=== Fixing Terraform Files ==="

# Функция для добавления минимального Terraform кода в файлы с только комментариями
add_minimal_terraform() {
    local file=$1
    if [ -f "$file" ] && ! grep -q -v -E '^\s*#|^\s*$' "$file"; then
        echo "Adding minimal Terraform code to $file"
        cat >> "$file" << 'EOT'

terraform {
  required_version = ">= 1.0"
}

output "placeholder" {
  value = "Minimal valid Terraform configuration"
}
EOT
    fi
}

# Обработаем проблемные файлы
for file in \
  ./04/demonstration1/vms/variables.tf \
  ./04/demonstration1/vms/main.tf \
  ./04/src/modules/mysql-cluster/main.tf \
  ./03/demo/variables.tf \
  ./03/demo/main.tf \
  ./03/src/variables.tf \
  ./03/src/disk_vm.tf \
  ./03/src/for_each-vm.tf \
  ./02/demo/demostration1.tf \
  ./02/src/variables.tf \
  ./02/src/console.tf; do
    add_minimal_terraform "$file"
done

echo "=== Running Terraform Format ==="
terraform fmt -recursive

echo "=== Fix Complete ==="
