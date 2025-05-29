# Домашнее задание к занятию «Введение в Terraform»

### Цели задания

1. Установить и настроить Terrafrom.
2. Научиться использовать готовый код.

------

### Чек-лист готовности к домашнему заданию

1. Скачайте и установите **Terraform** версии >=1.8.4 . Приложите скриншот вывода команды ```terraform --version```.
![изображение](https://github.com/user-attachments/assets/93e53616-1160-41c1-88ca-6fb492b17ed9)


2. Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории **01/src**.
3. Убедитесь, что в вашей ОС установлен docker.

![изображение](https://github.com/user-attachments/assets/9dce0b7f-8b63-4967-8337-33dd9ca3d1c4)



------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. Репозиторий с ссылкой на зеркало для установки и настройки Terraform: [ссылка](https://github.com/netology-code/devops-materials).
2. Установка docker: [ссылка](https://docs.docker.com/engine/install/ubuntu/). 
------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте.

файл .terraformrc необходимо скопировать в корень домашнего каталога

![изображение](https://github.com/user-attachments/assets/0e84fe23-73f8-4bea-bd34-698b042c0ad8)


2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)

personal.auto.tfvars (personal имя *.auto.tfvars  расширение)

3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
"bcrypt_hash": "$2a$10$zNvShKqz3MI2wn3yDoGgaexizDqp.siwQVQSCX1YRWYGpKzi1LoXS",
"result": "7hVEY4yhm2gCNf2m"

5. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
![изображение](https://github.com/user-attachments/assets/0c94ec18-38ed-4bcf-ad9c-cbe16a7d2b81)

1) Не указан параметр from ("from_resourse"  уникальное имя)
2) Описание не может начинаться с числа
3. Не верно был указан 2-й параметр (берется из П.1  уникальное имя) image = docker_image.from_resourse.image_id
4) name  = "example_${random_password.random_string.result}" убрал лишнее

7. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.


![изображение](https://github.com/user-attachments/assets/dbce5875-8209-412c-98fe-a2add278a717)


![изображение](https://github.com/user-attachments/assets/6917cb2b-37c9-4363-8c58-954f05802f8b)



8. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.
![изображение](https://github.com/user-attachments/assets/d1fdce65-9915-4c4f-ad1d-2d0d6f8175de)

Применение скрипта, который удаляет предыдущие наработки без ручного подтверждения, может быть случайным и привести к потере данных.
Интернет сообщает, что данный ключ может пригодиться для автоматизации процессов, например, в конвейерах CI/CD. 




10. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**.
terraform destroy
![изображение](https://github.com/user-attachments/assets/29141c16-a0b8-4cc1-9509-669e560c312b)

{
  "version": 4,
  "terraform_version": "1.12.1",
  "serial": 36,
  "lineage": "ace2637d-630a-67f8-d48f-febe127bc077",
  "outputs": {},
  "resources": [],
  "check_results": null
}



11. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ**, а затем **ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ** строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image )

keep_locally = true
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.




------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.** Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 

### Задание 2*

1. Создайте в облаке ВМ. Сделайте это через web-консоль, чтобы не слить по незнанию токен от облака в github(это тема следующей лекции). Если хотите - попробуйте сделать это через terraform, прочитав документацию yandex cloud. Используйте файл ```personal.auto.tfvars``` и гитигнор или иной, безопасный способ передачи токена!

Создал вручную
![изображение](https://github.com/user-attachments/assets/6b5a9ebe-bdf3-4f81-9edf-912ab5b28878)


2. Подключитесь к ВМ по ssh и установите стек docker.

Подключился используя ssh ключ и парольнцю фразу
![изображение](https://github.com/user-attachments/assets/a2048e8b-6a57-4c5d-ac73-891627050004)


3. Найдите в документации docker provider способ настроить подключение terraform на вашей рабочей станции к remote docker context вашей ВМ через ssh.

Убрать пароль с приватного ключа ->  ssh-keygen -p -P *** -N "" -f ~/.ssh/id_rsa
Добавить пользователя (Даже root) в группу docker  -> gpasswd -a $USER docker

![изображение](https://github.com/user-attachments/assets/60dd5950-0274-4fdf-901f-0d718fc2b1eb)



4. Используя terraform и  remote docker context, скачайте и запустите на вашей ВМ контейнер ```mysql:8``` на порту ```127.0.0.1:3306```, передайте ENV-переменные. Сгенерируйте разные пароли через random_password и передайте их в контейнер, используя интерполяцию из примера с nginx.(```name  = "example_${random_password.random_string.result}"```  , двойные кавычки и фигурные скобки обязательны!) 
```
    environment:
      - "MYSQL_ROOT_PASSWORD=${...}"
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - "MYSQL_PASSWORD=${...}"
      - MYSQL_ROOT_HOST="%"
```

6. Зайдите на вашу ВМ , подключитесь к контейнеру и проверьте наличие секретных env-переменных с помощью команды ```env```. Запишите ваш финальный код в репозиторий.
![изображение](https://github.com/user-attachments/assets/d267fbe5-688e-442f-a561-66c365112c67)

код:
https://github.com/olegveselov1984/ter-homeworks/blob/25d9dd5c49aea3718e3eba8c2eda5d87909c66d0/01/01.1/main.tf


terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=1.8.4"
}

provider "docker" {
  host = "ssh://user@84.201.181.8:22"
    ssh_opts = ["-i", "~/.ssh/id_rsa",]
}

resource "random_password" "mysql_root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "mysql_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = true
}


resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql_8"

  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }

  env = ["MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
         "MYSQL_DATABASE=wordpress",
         "MYSQL_USER=wordpress",
         "MYSQL_PASSWORD=${random_password.mysql_password.result}",
         "MYSQL_ROOT_HOST=%"]
  
   restart = "always"
  }







### Задание 3*
1. Установите [opentofu](https://opentofu.org/)(fork terraform с лицензией Mozilla Public License, version 2.0) любой версии
2. Попробуйте выполнить тот же код с помощью ```tofu apply```, а не terraform apply.
------

### Правила приёма работы

Домашняя работа оформляется в отдельном GitHub-репозитории в файле README.md.   
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 

