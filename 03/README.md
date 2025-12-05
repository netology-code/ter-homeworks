# Домашнее задание 03. Управляющие конструкции в коде Terraform

## Структура проекта
ter-hw-03/
├── README.md # Это файл
├── src/
│ ├── main.tf # Основная конфигурация (если потребуется)
│ ├── provider.tf # Конфигурация провайдера
│ ├── variables.tf # Основные переменные
│ ├── extra-variables.tf # Дополнительные переменные
│ ├── terraform.tfvars.example # Пример файла переменных
│ ├── count-vm.tf # Задание 2.1: ВМ с count loop
│ ├── for_each-vm.tf # Задание 2.2: ВМ с for_each loop
│ ├── disk_vm.tf # Задание 3: Диски и ВМ storage
│ ├── ansible.tf # Задание 4: Ansible inventory
│ ├── outputs.tf # Задание 5*: Output переменные
│ ├── locals.tf # Локальные переменные и задания 7-9*
│ ├── templates/
│ │ ├── inventory.tpl # Шаблон Ansible inventory
│ │ └── fixed_template.tpl # Исправленный шаблон (задание 8*)
│ └── inventory.ini # Сгенерированный inventory (после terraform apply)


## Установка и настройка

1. Клонируйте репозиторий:

git clone <ваш-репозиторий>
cd ter-hw-03/src
Настройте переменные:

cp terraform.tfvars.example terraform.tfvars
# Отредактируйте terraform.tfvars со своими значениями
Инициализируйте Terraform:

terraform init
Создайте SSH ключ (если нет):

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
Планирование и применение:

terraform plan
terraform apply
Выполненные задания
Задание 1
Изучена структура проекта

Проект инициализирован и выполнен

Задание 2
Созданы 2 одинаковые ВМ web-1 и web-2 (файл count-vm.tf)

Созданы 2 разные ВМ main и replica (файл for_each-vm.tf)

Реализована зависимость создания ВМ

Использована функция file() для чтения SSH ключа

Задание 3
Созданы 3 диска по 1 Гб с помощью count

Создана ВМ storage с динамическим подключением дисков

Задание 4
Создан динамический Ansible inventory

Инвентарь содержит 3 группы

Добавлена переменная fqdn

Inventory сгенерирован в файл inventory.ini

Задание 5* (необязательное)
Создан output all_vms, который возвращает список всех ВМ в формате:

json
[
  {
    "name": "web-1",
    "id": "fhmabc123",
    "fqdn": "web-1.ru-central1.internal"
  },
  ...
]
Задание 6* (необязательное)
Реализовано применение Ansible playbook через null_resource (код в демонстрации)

Задание 7* (необязательное)
Выражение для удаления 3-го элемента из subnet_ids и subnet_zones:

{
  network_id   = local.vpc_example.network_id
  subnet_ids   = [for i, id in local.vpc_example.subnet_ids : id if i != 2]
  subnet_zones = [for i, zone in local.vpc_example.subnet_zones : zone if i != 2]
}
Задание 8* (необязательное)
Исправленная ошибка в шаблоне:

${i["name"]} ansible_host=${i["nat_ip_address"]} platform_id=${i["platform_id"]}
(были незакрытая фигурная скобка и лишний проблом)

Задание 9* (необязательное)
Terraform выражения:

[for i in range(1, 100) : format("rc%02d", i)]

[for i in range(1, 97) : format("rc%02d", i) if (i % 10 != 0 && i % 10 != 7 && i % 10 != 8 && i % 10 != 9) || i == 19]

Запуск проекта

# Проверка конфигурации
terraform validate

# Просмотр плана
terraform plan

# Применение конфигурации
terraform apply -auto-approve

# Просмотр output
terraform output all_vms

# Проверка Ansible inventory
cat inventory.ini

# Уничтожение ресурсов
terraform destroy -auto-approve

Скриншоты
(Добавлены)

Примечания
Все ВМ создаются как прерываемые для экономии средств
спользована версия Terraform ~> 1.12.0
Код написан без хардкода значенийосле выполнения все ресурсы уничтожены
