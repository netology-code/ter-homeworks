
# Домашнее задание к занятию «Использование Terraform в команде»

### Цели задания

1. Научиться использовать remote state с блокировками.
2. Освоить приёмы командной работы.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.8.4
Пишем красивый код, хардкод значения не допустимы!

------
### Задание 0
1. Прочтите статью: https://neprivet.com/
2. Пожалуйста, распространите данную идею в своем коллективе.

------

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),
- из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
При создании файла .tflint.hcl и указании там кода (вывод информации более сжатый):
_________________________________________________________
tflint {
  required_version = ">= 0.50"
}

config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"
  call_module_type = "local"
}

# plugin "aws" {
#   enabled = true
#   version = "0.4.0"
#   source  = "github.com/terraform-linters/tflint-ruleset-aws"
# }

rule "terraform_required_version" {
  enabled = false
}
_________________________________________________________

TFLINT каталог vms и src. Дудли удалил.

main.tf:22:20: Warning - Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)
ссылка на верку main без указания версионности. Может сломаться при изменении версии
providers.tf:3:14: Warning - Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)
У провайдера не указана версия. Может сломаться при изменении версии
variables.tf:50:1: Warning - variable "vm_db_name" is declared but not used (terraform_unused_declarations)
переменная заявлена но не используется

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
не указана версия. Может сломаться при изменении версии		

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
необходимо указать URL Git с хэшем фиксации	

Code lines for this resource are too many. Please use IDE of your choice to review the file.
Слишком длинный путь. Нужно сократить		
  
3. Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей).

------

### Задание 2

1. Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.
![image](https://github.com/user-attachments/assets/9cd2074e-0cc2-4348-b989-acbe7ddd70e6)
![image](https://github.com/user-attachments/assets/5a25ce05-93e9-4ef7-9f86-b87c5d7c0817)
Локально:
![image](https://github.com/user-attachments/assets/4a9cd206-29ab-46ef-b014-5db63b62803c)
Бакет:
![image](https://github.com/user-attachments/assets/0f9f1fff-c3a4-44ac-865e-69d2621f8fb3)
![image](https://github.com/user-attachments/assets/20b30c80-94c5-493a-8429-b1be8f15ad1c)

![image](https://github.com/user-attachments/assets/9bc8ea31-3ca0-4295-a0e9-083519879a50)
![image](https://github.com/user-attachments/assets/7733a320-eee0-4113-a653-14303a81d8f3)
![image](https://github.com/user-attachments/assets/8eff0895-cb5a-48ac-bb4b-e5b832bda17f)
![image](https://github.com/user-attachments/assets/824ffb7c-46ad-4876-ad8b-d11d8058e46f)
![image](https://github.com/user-attachments/assets/6dd6acd8-20e1-4e0c-ad89-15f5e6061be3)
![image](https://github.com/user-attachments/assets/686c3e4f-0253-4bcb-aa84-11eaff297342)











4. Закоммитьте в ветку 'terraform-05' все изменения.
5. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
6. Пришлите ответ об ошибке доступа к state.
7. Принудительно разблокируйте state. Пришлите команду и вывод.


------
### Задание 3  

1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
2. Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит.
3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'. 
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно.

------
### Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console. 

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].

## Дополнительные задания (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 
------
### Задание 5*
1. Напишите переменные с валидацией:
- type=string, description="любая строка" — проверка, что строка не содержит символов верхнего регистра;
- type=object — проверка, что одно из значений равно true, а второе false, т. е. не допускается false false и true true:
```
variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = <проверка>
    }
}
```
------
### Задание 6*

1. Настройте любую известную вам CI/CD-систему. Если вы ещё не знакомы с CI/CD-системами, настоятельно рекомендуем вернуться к этому заданию после изучения Jenkins/Teamcity/Gitlab.
2. Скачайте с её помощью ваш репозиторий с кодом и инициализируйте инфраструктуру.
3. Уничтожьте инфраструктуру тем же способом.


------
### Задание 7*
1. Настройте отдельный terraform root модуль, который будет создавать YDB, s3 bucket для tfstate и сервисный аккаунт с необходимыми правами. 

### Правила приёма работы

Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-05.

В качестве результата прикрепите ссылку на ветку terraform-05 в вашем репозитории.

**Важно.** Удалите все созданные ресурсы.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 



