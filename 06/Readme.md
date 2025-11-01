# Terramate - Базовые команды

## Генерация Terraform кода

```bash
# Генерация .tf файлов из .tm.hcl шаблонов
terramate generate

# Удаление сгенерированных файлов и перегенерация
rm stacks/dev/*.tf stacks/prod/*.tf
terramate generate

```

## Работа со стеками

```bash
# Список всех стеков
terramate list

# Выполнить команду во всех стеках
# Если backend изменился, используй -migrate-state
terramate run --disable-safeguards=all terraform init
terramate run --disable-safeguards=all terraform plan
terramate run --disable-safeguards=all terraform apply

# Если Terramate ругается на untracked files, используй один из вариантов:
# Вариант 1: Обойти проверку (для тестирования)
terramate run --disable-safeguards=all terraform init

# Вариант 2: Закоммитить изменения (правильный подход)
git add . && git commit -m "Update infrastructure"
terramate run terraform init

# Выполнить команду в конкретном стеке без обертки Terramate
cd stacks/dev
terraform init
terraform plan
terraform apply

```


## Структура проекта

```
06/
├── terramate.tm.hcl              # Корневая конфигурация
├── cloud-init.yml                # Cloud-init для VM
├── modules/yandex_cloud/vms/
│   └── vms.tm.hcl               # Шаблоны генерации .tf файлов
└── stacks/
    ├── dev/
    │   ├── stack.tm.hcl         # Globals для dev окружения
    │   └── *.tf                 # Сгенерированные файлы (в .gitignore)
    └── prod/
        ├── stack.tm.hcl         # Globals для prod окружения
        └── *.tf                 # Сгенерированные файлы (в .gitignore)
```

## Workflow

1. Изменить параметры в `stacks/{dev,prod}/stack.tm.hcl` (globals)
2. Запустить `terramate generate` для генерации .tf файлов
3. Перейти в директорию стека `cd stacks/dev`
4. Выполнить стандартные команды Terraform: `init`, `plan`, `apply`

## Что параметризируется через globals

- `env_name` - название окружения
- `subnet_zones` - список зон доступности
- `subnet_cidrs` - CIDR блоки для подсетей
- `vm_count` - количество виртуальных машин
- `instance_name` - имя инстансов
- `image_family` - семейство образа
- `labels` - метки ресурсов

