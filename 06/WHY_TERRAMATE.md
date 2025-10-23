# Зачем нужен Terramate?

## Проблема: Управление множественными окружениями в Terraform

При работе с Terraform в реальных проектах часто возникают следующие проблемы:

### 1. Дублирование кода

**Без Terramate:**
```
project/
├── dev/
│   ├── backend.tf       # Одинаковый код
│   ├── providers.tf     # Одинаковый код
│   ├── variables.tf     # Почти одинаковый код
│   └── main.tf
├── staging/
│   ├── backend.tf       # Копия с небольшими изменениями
│   ├── providers.tf     # Копия с небольшими изменениями
│   ├── variables.tf     # Копия с небольшими изменениями
│   └── main.tf
└── prod/
    ├── backend.tf       # Еще одна копия
    ├── providers.tf     # Еще одна копия
    ├── variables.tf     # Еще одна копия
    └── main.tf
```

**Проблемы:**
- При изменении backend нужно обновлять 3+ файла
- Риск ошибок при копировании
- Сложно поддерживать консистентность
- Много повторяющегося кода

### 2. Отсутствие оркестрации

**Задача:** Выполнить `terraform plan` для всех окружений

**Без Terramate:**
```bash
cd dev && terraform plan && cd ..
cd staging && terraform plan && cd ..
cd prod && terraform plan && cd ..
```

**С Terramate:**
```bash
terramate run terraform plan
```

### 3. Управление зависимостями между стеками

**Проблема:** Prod зависит от Infra, который зависит от Network

**Без Terramate:**
- Вручную отслеживать порядок применения
- Писать скрипты для оркестрации
- Риск применить изменения в неправильном порядке

**С Terramate:**
```hcl
# Автоматическое определение порядка через before/after
stack {
  after = ["../infra"]
}
```

### 4. Обнаружение изменений

**Задача:** Применить изменения только для модифицированных стеков

**Без Terramate:**
- Вручную анализировать, что изменилось
- Либо применять всё подряд (медленно и рискованно)

**С Terramate:**
```bash
terramate run --changed terraform apply
```

## Решение: Terramate

### Основные преимущества

#### 1. DRY (Don't Repeat Yourself)

**Пишем один раз:**
```hcl
# imports/backend.tm.hcl
generate_hcl "_backend.tf" {
  content {
    terraform {
      backend "s3" {
        bucket = global.backend.bucket
        key    = "${terramate.stack.path.relative}/terraform.tfstate"
      }
    }
  }
}
```

**Используем везде:**
- Автоматически генерируется для каждого стека
- Единая точка изменения
- Гарантия консистентности

#### 2. Глобальные переменные

```hcl
# config.tm.hcl
globals {
  project = "myproject"
  region  = "ru-central1"
  
  backend {
    bucket = "myproject-tfstate"
  }
}
```

Доступны во всех стеках через `global.*`

#### 3. Переопределение на уровне окружения

```hcl
# stacks/dev/config.tm.hcl
globals {
  environment = "dev"
  replicas    = 1
}

# stacks/prod/config.tm.hcl
globals {
  environment = "prod"
  replicas    = 3
}
```

#### 4. Встроенная оркестрация

```bash
# Все стеки
terramate run terraform plan

# Фильтрация по тегам
terramate run --tags prod terraform apply

# Только измененные
terramate run --changed terraform plan

# В параллель
terramate run --parallel 4 terraform plan
```

## Сравнение подходов

### Workspace vs Terramate

#### Terraform Workspaces

**Плюсы:**
- Встроено в Terraform
- Не требует дополнительных инструментов

**Минусы:**
- Общий код для всех окружений (сложно различать)
- Один backend для всех workspace
- Сложно управлять разными версиями провайдеров
- Нет параллельного выполнения
- Риск случайного переключения workspace

#### Terramate Stacks

**Плюсы:**
- Полная изоляция state файлов
- Гибкая структура проекта
- Генерация кода
- Встроенная оркестрация
- Обнаружение изменений
- Параллельное выполнение

**Минусы:**
- Дополнительный инструмент для установки
- Кривая обучения

### Модули vs Terramate

#### Terraform Modules

**Для чего:** Переиспользование логики инфраструктуры

```hcl
module "vpc" {
  source = "./modules/vpc"
  cidr   = "10.0.0.0/16"
}
```

**Плюсы:**
- Абстракция сложности
- Переиспользование между проектами
- Версионирование

#### Terramate

**Для чего:** Управление множественными окружениями

**Не конфликтует с модулями!** Можно использовать вместе:

```hcl
# main.tf в стеке
module "vpc" {
  source = "./modules/vpc"
  cidr   = global.vpc.cidr  # Из Terramate globals
}
```

## Когда использовать Terramate?

### ✅ Используйте Terramate если:

1. **Множественные окружения** (dev, staging, prod)
2. **Дублирование кода** между окружениями
3. **Нужна оркестрация** нескольких стеков
4. **Сложная инфраструктура** с зависимостями
5. **Большая команда** работает над инфраструктурой
6. **Монорепозиторий** с множеством Terraform проектов

### ❌ Не обязательно использовать если:

1. **Одно окружение** - достаточно обычного Terraform
2. **Простая инфраструктура** - нет смысла усложнять
3. **Маленький проект** - overhead не оправдан
4. **Прототип** - быстрее начать с чистого Terraform

## Реальный пример

### Было (без Terramate):

```
project/
├── dev/
│   ├── backend.tf        (50 строк)
│   ├── providers.tf      (30 строк)
│   ├── variables.tf      (100 строк)
│   └── main.tf           (200 строк)
├── staging/
│   ├── backend.tf        (50 строк, копия)
│   ├── providers.tf      (30 строк, копия)
│   ├── variables.tf      (100 строк, почти копия)
│   └── main.tf           (200 строк)
└── prod/
    ├── backend.tf        (50 строк, копия)
    ├── providers.tf      (30 строк, копия)
    ├── variables.tf      (100 строк, почти копия)
    └── main.tf           (200 строк)

Итого: ~1000 строк, из которых ~400 дублируются
```

### Стало (с Terramate):

```
project/
├── config.tm.hcl         (20 строк)
├── imports/
│   ├── backend.tm.hcl    (15 строк)
│   ├── providers.tm.hcl  (20 строк)
│   └── variables.tm.hcl  (30 строк)
└── stacks/
    ├── dev/
    │   ├── config.tm.hcl (5 строк)
    │   └── main.tf       (200 строк)
    ├── staging/
    │   ├── config.tm.hcl (5 строк)
    │   └── main.tf       (200 строк)
    └── prod/
        ├── config.tm.hcl (5 строк)
        └── main.tf       (200 строк)

Итого: ~700 строк, дублирования практически нет
```

**Экономия:** 30% кода + единая точка изменения

## Интеграция с существующими практиками

### CI/CD

```yaml
# GitLab CI
stages:
  - validate
  - plan
  - apply

validate:
  script:
    - terramate generate --check
    - terramate run terraform fmt -check
    - terramate run terraform validate

plan:
  script:
    - terramate run --changed terraform plan -out=tfplan
  artifacts:
    paths:
      - "**/tfplan"

apply:
  script:
    - terramate run --changed terraform apply tfplan
  when: manual
  only:
    - main
```

### Pre-commit hooks

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: terramate-generate
        name: Terramate Generate
        entry: terramate generate --check
        language: system
        pass_filenames: false
```

### GitOps

Terramate отлично работает с GitOps подходом:
1. Изменения только через PR
2. Автоматический plan в PR
3. Apply после merge
4. История изменений в Git

## Миграция с чистого Terraform

### Шаг 1: Анализ структуры

Определите, что можно вынести в globals и генераторы:
- Backend конфигурация
- Provider версии
- Общие переменные
- Теги

### Шаг 2: Создание структуры Terramate

```bash
# Корневая конфигурация
touch terramate.tm.hcl config.tm.hcl

# Генераторы
mkdir imports
touch imports/backend.tm.hcl
touch imports/providers.tm.hcl

# Стеки
mkdir -p stacks/dev stacks/prod
```

### Шаг 3: Миграция окружения

```bash
# Для каждого окружения
cd stacks/dev
touch config.tm.hcl stack.tm.hcl
mv /path/to/old/dev/main.tf ./main.tf

# Удалите дублирующиеся файлы
rm backend.tf providers.tf
```

### Шаг 4: Генерация и проверка

```bash
terramate generate
terraform init -reconfigure
terraform plan
```

## Итого

**Terramate** - это не замена Terraform, а **дополнение** для:
- Управления множественными окружениями
- Устранения дублирования кода
- Оркестрации выполнения
- Масштабирования инфраструктуры как кода

Используйте его, когда проект вырос из одного окружения и начинается дублирование кода между dev/staging/prod.

## Дополнительные ресурсы

- [Официальная документация](https://terramate.io/docs/)
- [Сравнение с альтернативами](https://terramate.io/docs/alternatives/)
- [Best Practices](https://terramate.io/docs/cli/best-practices/)
- [Примеры проектов](https://github.com/terramate-io/terramate/tree/main/examples)

