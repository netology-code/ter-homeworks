#!/bin/bash

echo "=========================================="
echo "🔍 ПРОВЕРКА ВЫПОЛНЕНИЯ ЗАДАНИЯ"
echo "=========================================="
echo "Задание: Создать модуль для БД и пользователя в MySQL кластере"
echo ""

# Проверка 1: Существует ли модуль
echo "1. Проверка модуля mysql-database..."
if [ -d "modules/mysql-database" ]; then
    echo "   ✅ Директория modules/mysql-database/ существует"
else
    echo "   ❌ Директория modules/mysql-database/ не существует"
    exit 1
fi

# Проверка 2: Все ли файлы созданы
echo ""
echo "2. Проверка файлов модуля..."
files=("variables.tf" "main.tf" "outputs.tf")
all_files_exist=true

for file in "${files[@]}"; do
    if [ -f "modules/mysql-database/$file" ]; then
        echo "   ✅ modules/mysql-database/$file существует"
    else
        echo "   ❌ modules/mysql-database/$file не существует"
        all_files_exist=false
    fi
done

if [ "$all_files_exist" != "true" ]; then
    echo "   ❌ Не все файлы модуля созданы"
    exit 1
fi

# Проверка 3: Обязательные переменные
echo ""
echo "3. Проверка обязательных переменных..."
required_vars=("cluster_id" "database_name" "username" "password")
all_vars_exist=true

for var in "${required_vars[@]}"; do
    if grep -q "variable \"$var\"" modules/mysql-database/variables.tf; then
        echo "   ✅ Переменная '$var' объявлена"
    else
        echo "   ❌ Переменная '$var' не объявлена"
        all_vars_exist=false
    fi
done

if [ "$all_vars_exist" != "true" ]; then
    echo "   ❌ Не все обязательные переменные объявлены"
    exit 1
fi

# Проверка 4: Ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user
echo ""
echo "4. Проверка ресурсов..."
if grep -q "yandex_mdb_mysql_database" modules/mysql-database/main.tf; then
    echo "   ✅ Ресурс yandex_mdb_mysql_database создан"
else
    echo "   ❌ Ресурс yandex_mdb_mysql_database не создан"
    exit 1
fi

if grep -q "yandex_mdb_mysql_user" modules/mysql-database/main.tf; then
    echo "   ✅ Ресурс yandex_mdb_mysql_user создан"
else
    echo "   ❌ Ресурс yandex_mdb_mysql_user не создан"
    exit 1
fi

# Проверка 5: Использование переменных в ресурсах
echo ""
echo "5. Проверка использования переменных..."
if grep -q "var.cluster_id" modules/mysql-database/main.tf; then
    echo "   ✅ Используется var.cluster_id"
else
    echo "   ❌ Не используется var.cluster_id"
    exit 1
fi

if grep -q "var.database_name" modules/mysql-database/main.tf; then
    echo "   ✅ Используется var.database_name"
else
    echo "   ❌ Не используется var.database_name"
    exit 1
fi

if grep -q "var.username" modules/mysql-database/main.tf; then
    echo "   ✅ Используется var.username"
else
    echo "   ❌ Не используется var.username"
    exit 1
fi

# Проверка 6: Outputs
echo ""
echo "6. Проверка outputs..."
if grep -q "output" modules/mysql-database/outputs.tf; then
    echo "   ✅ Outputs созданы"
else
    echo "   ❌ Outputs не созданы"
fi

# Итоговый результат
echo ""
echo "=========================================="
echo "🎉 ИТОГОВЫЙ РЕЗУЛЬТАТ ПРОВЕРКИ"
echo "=========================================="
echo ""
echo "✅ ЗАДАНИЕ ВЫПОЛНЕНО!"
echo ""
echo "📊 Выполненные требования:"
echo "   - Модуль создан в modules/mysql-database/ ✅"
echo "   - Используются ресурсы yandex_mdb_mysql_database ✅"
echo "   - Используются ресурсы yandex_mdb_mysql_user ✅"
echo "   - Передаются переменные: cluster_id, database_name, username ✅"
echo "   - Все обязательные файлы созданы ✅"
echo ""
echo "🚀 Модуль готов к использованию!"
echo "Пример использования:"
echo "module \"app_db\" {"
echo "  source       = \"./modules/mysql-database\""
echo "  cluster_id   = \"your-cluster-id\""
echo "  database_name = \"myapp\""
echo "  username     = \"app_user\""
echo "  password     = \"secure_password\""
echo "}"
echo "=========================================="
