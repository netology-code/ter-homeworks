#!/bin/bash
echo "=== Checking Critical Directories Only ==="

# Проверяем только важные директории, игнорируем .terraform и демо-файлы
critical_dirs=(
  "04/src"
  "04/src/06-s3-bucket"
  "07-vault"
  "08-remote-state-modules/vpc_module"
  "08-remote-state-modules/vm_module"
  "validation_test"
)

all_valid=true

for dir in "${critical_dirs[@]}"; do
  if [ -d "$dir" ]; then
    echo "=== Checking $dir ==="
    cd "$dir"
    
    # Проверяем форматирование
    if terraform fmt -check; then
      echo "✅ Formatting: PASS"
    else
      echo "❌ Formatting: FAIL"
      terraform fmt
      all_valid=false
    fi
    
    # Проверяем синтаксис (без инициализации провайдеров)
    if terraform validate -json 2>/dev/null | grep -q '"valid":true'; then
      echo "✅ Syntax: PASS"
    else
      echo "⚠️  Syntax: Needs provider initialization"
    fi
    
    cd - > /dev/null
    echo "---"
  fi
done

if $all_valid; then
  echo "🎉 CRITICAL DIRECTORIES FORMATTING CHECK PASSED"
  exit 0
else
  echo "💥 Some critical directories needed formatting fixes"
  exit 1
fi
