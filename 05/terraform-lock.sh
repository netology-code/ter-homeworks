#!/bin/bash

# Скрипт для блокировки Terraform операций
LOCK_FILE=".terraform/.terraform.lock"
MAX_WAIT=300
WAIT_INTERVAL=5

acquire_lock() {
    local wait_time=0
    
    while [ -f "$LOCK_FILE" ] && [ $wait_time -lt $MAX_WAIT ]; do
        echo "⏳ Terraform операция уже выполняется. Жду... ($wait_time/$MAX_WAIT сек.)"
        sleep $WAIT_INTERVAL
        wait_time=$((wait_time + WAIT_INTERVAL))
    done
    
    if [ -f "$LOCK_FILE" ]; then
        echo "❌ Ошибка: Не удалось получить блокировку за $MAX_WAIT секунд"
        echo "   Если уверены, что операций нет, удалите файл: rm $LOCK_FILE"
        exit 1
    fi
    
    mkdir -p .terraform
    touch "$LOCK_FILE"
    echo "🔒 Блокировка установлена (PID: $$)"
}

release_lock() {
    if [ -f "$LOCK_FILE" ]; then
        rm -f "$LOCK_FILE"
        echo "🔓 Блокировка снята"
    fi
}

trap release_lock EXIT INT TERM

acquire_lock

echo "🚀 Выполняю: terraform $@"
terraform "$@"

EXIT_CODE=$?
echo "✅ Terraform операция завершена с кодом: $EXIT_CODE"
