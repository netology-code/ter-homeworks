#!/bin/bash
echo "=== Validating Terraform in all directories ==="

for dir in $(find . -name "*.tf" -exec dirname {} \; | sort -u); do
    echo "=== Checking $dir ==="
    
    # Создаем временный main.tf если его нет
    if [ ! -f "$dir/main.tf" ] && [ ! -f "$dir/providers.tf" ]; then
        echo "Creating minimal main.tf in $dir"
        cat > "$dir/main.tf" << 'EOT'
terraform {
  required_version = ">= 1.0"
}

output "placeholder" {
  value = "Minimal configuration for validation"
}
EOT
    fi
    
    # Проверяем синтаксис
    cd "$dir"
    if terraform init -backend=false > /dev/null 2>&1 && terraform validate; then
        echo "✅ $dir - Valid"
    else
        echo "❌ $dir - Invalid"
        terraform validate || true
    fi
    cd - > /dev/null
    echo "---"
done
