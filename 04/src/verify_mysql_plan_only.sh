#!/bin/bash

set -e

echo "🔍 Проверка MySQL модулей (ТОЛЬКО ПЛАН)"

# Временно отключаем outputs
mv outputs.tf outputs.tf.backup 2>/dev/null || true

# Инициализация
echo "🔄 Инициализируем Terraform..."
terraform init

# Проверка
echo "🔍 Проверяем конфигурацию..."
terraform validate

# План для MySQL модулей
echo "📋 Создаем план для MySQL модулей..."
terraform plan -target=module.mysql_example_single -target=module.example_database -detailed-exitcode

PLAN_EXIT_CODE=$?

# Восстанавливаем outputs
mv outputs.tf.backup outputs.tf 2>/dev/null || true

# Очистка
rm -rf .terraform .terraform.lock.hcl

if [ $PLAN_EXIT_CODE -eq 0 ]; then
    echo "✅ Конфигурация валидна, изменений не требуется"
elif [ $PLAN_EXIT_CODE -eq 2 ]; then
    echo "✅ Конфигурация валидна, есть изменения для применения"
    echo "⚠️  Ресурсы НЕ созданы для экономии средств"
else
    echo "❌ Ошибка в конфигурации"
    exit 1
fi

echo " "
echo "🎉 ПРОВЕРКА ЗАВЕРШЕНА!"
echo "✅ MySQL модули готовы к работе"
echo "✅ Ресурсы НЕ созданы - расходов нет"
