# Демонстрация Terramate

Этот проект демонстрирует основные возможности Terramate для управления множественными Terraform стеками.

## Структура проекта

```
.
├── terramate.tm.hcl           # Конфигурация Terramate
├── config.tm.hcl              # Глобальные переменные
├── imports/                   # Переиспользуемые компоненты
│   ├── backend.tm.hcl         # Генерация backend конфигурации
│   └── providers.tm.hcl       # Генерация providers конфигурации
└── stacks/                    # Стеки приложений
    └── example/
        ├── dev/               # Development окружение
        │   └── app/
        │       ├── stack.tm.hcl
        │       └── main.tf
        └── prod/              # Production окружение
            └── app/
                ├── stack.tm.hcl
                └── main.tf
```

## Что такое Terramate?

Terramate - это инструмент для управления множественными Terraform проектами (стеками).

### Основные возможности:

1. **DRY (Don't Repeat Yourself)** - переиспользование конфигураций
2. **Генерация кода** - автоматическое создание повторяющихся файлов
3. **Глобальные переменные** - единые настройки для всех стеков
4. **Оркестрация** - выполнение команд для нескольких стеков
5. **Обнаружение изменений** - запуск только измененных стеков

## Установка Terramate

### Linux/MacOS:
```bash
curl -sfL https://github.com/terramate-io/terramate/releases/latest/download/terramate_$(uname -s)_$(uname -m).tar.gz | tar -xz -C /usr/local/bin terramate
```

### Windows:
Скачайте бинарник с [GitHub Releases](https://github.com/terramate-io/terramate/releases)

### Проверка:
```bash
terramate version
```

## Быстрый старт

### 1. Генерация Terraform файлов

Terramate автоматически генерирует файлы на основе шаблонов:

```bash
terramate generate
```

После выполнения в каждом стеке появятся файлы:
- `_backend.tf` - конфигурация backend
- `_providers.tf` - конфигурация providers

### 2. Просмотр стеков

```bash
# Список всех стеков
terramate list

# Детальная информация
terramate list --tags
```

### 3. Инициализация Terraform

```bash
# Для всех стеков
terramate run terraform init

# Только для dev окружения
terramate run --tags dev terraform init

# Только для конкретного стека
cd stacks/example/dev/app
terraform init
```

### 4. План изменений

```bash
# Для всех стеков
terramate run terraform plan

# Для prod окружения
terramate run --tags prod terraform plan
```

### 5. Применение изменений

```bash
# Для dev
terramate run --tags dev terraform apply -auto-approve

# Для prod (без auto-approve для безопасности)
terramate run --tags prod terraform apply
```

## Основные команды Terramate

### Управление стеками

```bash
# Список стеков
terramate list

# Список с тегами
terramate list --tags

# Фильтрация по тегам
terramate list --tags dev
terramate list --tags prod
```

### Генерация кода

```bash
# Генерация всех файлов
terramate generate

# Проверка, что все файлы актуальны
terramate generate --check
```

### Выполнение команд

```bash
# Запуск команды во всех стеках
terramate run <команда>

# С фильтрацией по тегам
terramate run --tags dev terraform plan

# С фильтрацией по имени
terramate run --changed terraform apply
```

### Отладка

```bash
# Показать глобальные переменные
terramate debug show globals

# Показать метаданные стека
cd stacks/example/dev/app
terramate debug show metadata
```

## Концепции Terramate

### 1. Globals (Глобальные переменные)

Определяются в `config.tm.hcl` и доступны во всех стеках:

```hcl
globals {
  project     = "netology"
  environment = "null"
}
```

Могут быть переопределены на уровне стека:

```hcl
# stacks/example/dev/config.tm.hcl
globals {
  environment = "dev"
}
```

### 2. Generate (Генерация кода)

Автоматическое создание файлов на основе шаблонов:

```hcl
generate_hcl "_backend.tf" {
  content {
    terraform {
      backend "s3" {
        bucket = global.terraform.backend.bucket
        key    = "${terramate.stack.path.relative}/terraform.tfstate"
      }
    }
  }
}
```

### 3. Stacks (Стеки)

Каждый стек - независимый Terraform проект с собственным state:

```hcl
stack {
  name        = "app"
  description = "Development application stack"
  tags        = ["dev", "app"]
  id          = "dev-app-001"
}
```

### 4. Import (Импорт)

Переиспользование конфигураций:

```hcl
import {
  source = "/imports/*.tm.hcl"
}
```

## Примеры использования

### Пример 1: Применение изменений только для dev

```bash
# Генерируем файлы
terramate generate

# Инициализируем только dev стеки
terramate run --tags dev terraform init

# Применяем изменения
terramate run --tags dev terraform apply
```

### Пример 2: Проверка всех окружений

```bash
# План для всех окружений
terramate run terraform plan

# Сохранение планов
terramate run terraform plan -out=tfplan
```

### Пример 3: Работа с конкретным стеком

```bash
cd stacks/example/prod/app

# Генерация только для этого стека
terramate generate

# Обычные Terraform команды
terraform init
terraform plan
terraform apply
```

### Пример 4: Обнаружение изменений

```bash
# Показать измененные стеки
terramate list --changed

# Применить только измененные
terramate run --changed terraform apply
```

## Переменные окружения в Globals

В `main.tf` можно использовать глобальные переменные:

```hcl
locals {
  app_name    = "${global.project}-${global.environment}-app"
  environment = global.environment
  region      = global.region
}
```

## Метаданные Terramate

Автоматически доступные переменные:

```hcl
${terramate.stack.name}              # Имя стека
${terramate.stack.path.relative}     # Относительный путь
${terramate.stack.path.absolute}     # Абсолютный путь
${terramate.stack.id}                # ID стека
${terramate.stack.tags}              # Теги стека
```

## Преимущества Terramate

1. **Масштабируемость** - легко добавлять новые окружения
2. **Консистентность** - одинаковая конфигурация везде
3. **Скорость** - изменения только в нужных стеках
4. **Безопасность** - изоляция state файлов
5. **Читаемость** - меньше дублирования кода

## Сравнение с обычным Terraform

### Без Terramate:

```
project/
├── dev/
│   ├── backend.tf      # Дублирование
│   ├── providers.tf    # Дублирование
│   └── main.tf
└── prod/
    ├── backend.tf      # Дублирование
    ├── providers.tf    # Дублирование
    └── main.tf
```

### С Terramate:

```
project/
├── imports/
│   ├── backend.tm.hcl      # Один раз
│   └── providers.tm.hcl    # Один раз
└── stacks/
    ├── dev/main.tf
    └── prod/main.tf
```

## Дополнительные ресурсы

- [Документация Terramate](https://terramate.io/docs/)
- [GitHub Terramate](https://github.com/terramate-io/terramate)
- [Примеры](https://github.com/terramate-io/terramate/tree/main/examples)

## Troubleshooting

### Ошибка: "stack not found"
```bash
# Убедитесь, что находитесь в корне проекта или внутри стека
terramate list
```

### Ошибка: "generation outdated"
```bash
# Перегенерируйте файлы
terramate generate
```

### Файлы не генерируются
```bash
# Проверьте условие в generate_hcl
# condition = global.environment != "null"
```

## Следующие шаги

1. Изучите структуру проекта
2. Запустите `terramate generate`
3. Посмотрите сгенерированные файлы `_backend.tf` и `_providers.tf`
4. Попробуйте запустить `terraform init` в одном из стеков
5. Изучите домашнее задание в `hw-06.md`

