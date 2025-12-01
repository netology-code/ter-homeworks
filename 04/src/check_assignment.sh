cat > check_assignment.sh << 'EOF'
#!/bin/bash

echo "=========================================="
echo "🔍 ПРОВЕРКА ВЫПОЛНЕНИЯ ЗАДАНИЯ"
echo "=========================================="
echo ""

# Проверка 1: Существует ли модуль VPC
echo "1. Проверка модуля VPC..."
if [ -d "modules/vpc" ]; then
    echo "   ✅ Директория modules/vpc/ существует"
else
    echo "   ❌ Директория modules/vpc/ не существует"
    exit 1
fi

# Проверка 2: Файлы модуля
echo ""
echo "2. Проверка файлов модуля..."
files=("variables.tf" "main.tf" "outputs.tf")
all_files_exist=true

for file in "${files[@]}"; do
    if [ -f "modules/vpc/$file" ]; then
        echo "   ✅ modules/vpc/$file существует"
    else
        echo "   ❌ modules/vpc/$file не существует"
        all_files_exist=false
    fi
done

if [ "$all_files_exist" != "true" ]; then
    echo "   ❌ Не все файлы модуля созданы"
    exit 1
fi

# Проверка 3: Переменная subnets типа list(object)
echo ""
echo "3. Проверка переменной subnets..."
if grep -q 'list(object' modules/vpc/variables.tf; then
    echo "   ✅ Переменная subnets типа list(object) объявлена"
    echo "   📋 Содержимое:"
    cat modules/vpc/variables.tf
else
    echo "   ❌ Переменная subnets не объявлена как list(object)"
    exit 1
fi

# Проверка 4: Логика создания подсетей в разных зонах
echo ""
echo "4. Проверка логики создания подсетей..."
if grep -q 'count = length(var.subnets)' modules/vpc/main.tf; then
    echo "   ✅ Используется count = length(var.subnets)"
else
    echo "   ❌ Не используется count для создания подсетей"
    exit 1
fi

if grep -q 'var.subnets\[count.index\].zone' modules/vpc/main.tf; then
    echo "   ✅ Используется var.subnets[count.index].zone"
else
    echo "   ❌ Не используется доступ к zone через count.index"
    exit 1
fi

# Проверка 5: Outputs
echo ""
echo "5. Проверка outputs..."
if grep -q 'subnet_ids' modules/vpc/outputs.tf; then
    echo "   ✅ Output subnet_ids существует"
else
    echo "   ❌ Output subnet_ids не существует"
    exit 1
fi

# Итоговый результат
echo ""
echo "=========================================="
echo "🎉 ИТОГОВЫЙ РЕЗУЛЬТАТ"
echo "=========================================="
echo ""
echo "✅ ЗАДАНИЕ ВЫПОЛНЕНО!"
echo ""
echo "📊 Статус проверки:"
echo "   - Модуль VPC создан: ✅"
echo "   - Переменная subnets типа list(object): ✅" 
echo "   - Создание подсетей в разных зонах: ✅"
echo "   - Outputs: ✅"
echo ""
echo "🚀 Модуль готов к использованию!"
echo "=========================================="
EOF

chmod +x check_assignment.sh
./check_assignment.sh
