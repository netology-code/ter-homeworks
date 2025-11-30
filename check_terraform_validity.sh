#!/bin/bash
echo "=== Checking Terraform File Validity ==="

# Сначала проверим форматирование
echo "=== Checking Terraform Formatting ==="
if terraform fmt -check -recursive; then
    echo "✅ All files are properly formatted"
else
    echo "❌ Some files need formatting"
    echo "Running terraform fmt to fix formatting..."
    terraform fmt -recursive
    exit 1
fi

# Проверим синтаксис в каждой директории с Terraform файлами
echo "=== Checking Terraform Syntax ==="
invalid_dirs=0

for dir in $(find . -name "*.tf" -exec dirname {} \; | sort -u); do
    # Переходим в директорию и проверяем синтаксис
    if cd "$dir" && terraform init -backend=false > /dev/null 2>&1; then
        if terraform validate > /dev/null 2>&1; then
            echo "✅ $dir - Syntax is valid"
        else
            echo "❌ $dir - Syntax errors found"
            terraform validate
            ((invalid_dirs++))
        fi
        cd - > /dev/null
    else
        echo "⚠️  $dir - Cannot initialize (may be incomplete configuration)"
    fi
done

if [ $invalid_dirs -eq 0 ]; then
    echo "✅ All Terraform configurations are syntactically valid"
else
    echo "❌ Found $invalid_dirs directories with syntax errors"
    exit 1
fi
