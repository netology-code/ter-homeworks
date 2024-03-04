### Чек-лист готовности к домашнему заданию

[](img/HW01_Checklist.png)



### Задание 1

1. Установка необходимых  зависимостей
    [](img/HW01_Requirements.png)

2. В фалйе personal.auto.tfvars

3. Содержимое созданного ресурса **random_password**

    [](img/HW01_Random_pass.png)

```bash
"result": "Jy5FlSyM5LHkBdTP"
```

4. terraform validate:
   - при объявлении  ресурса (в данном  случае имя образа  docker),  не указан один из        параметров - name (имя ресурса). Для всех  блоков  ресурсов обязательна передача 2-х  аргументов  -  type   и  name
   
   - при объявлении  ресурса docker_container некорректно указан параметр name. Согласно документции имя  должно начинаться с буквы или нижнего  подчеркивания и может содержать только буквы, цифры,  подчеркивания и дефисы


   Также допущены ошибки при обращении к ресурсам  - terraform  пытается обратиться к ресурсу,  которого нет,  и к атрибуту,  которого не существует

```bash
    A managed resource "random_password" "random_string_FAKE" has not been declared in the root module. 
```

```bash
   This object has no argument, nested block, or exported attribute named "resulT"
``` 
   
   Для корректной работы строка с объявлением имени контейнера  должна иметь  вид

```bash
   name  = "example_${random_password.random_string.result}"
```

   Исправленный код 

```bash 
resource "docker_image" "nginx" {
   name         = "nginx:latest"
   keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```

Вывод  команды  ```docker ps```

[](img/HW01_Docker_ps.png)

```bash
[root@terraform01 src]# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
746759ab17c1   e4720093a3c1   "/docker-entrypoint.…"   13 seconds ago   Up 12 seconds   0.0.0.0:9090->80/tcp   example_Jy5FlSyM5LHkBdTP
```

После изменения имени  контейнера  и применения  ```terraform apply --auto-approve``

[](img/HW01_Docker_ps_approve.png)

Как можно догадаться даже из  дословного  переводе ```auto-approve``` (автоматическое согласование/утверждение) данный ключ применит все изменения без  интерактивного  участия  пользователя. Применять такой ключ не рекомендуется, т.к. в случае такого изменения  при наличии ошибки в коде  можно потерять доступ к созданным ресурсам или даже удалить  их, что особенно критично для продуктивных БД, в которых хранятся пользовательские данные.
    
Применение данного  ключа актуально  для  CI/CD пайплайнов,  где развертывание  и настройка ресурсов должны производиться в атоматическом режиме без  участия пользователя по заранее написаному  сценарию. 

Применение ```terraform destroy```

Содержимое файла ```terraform.tf.state```
```bash
{
  "version": 4,
  "terraform_version": "1.5.7",
  "serial": 22,
  "lineage": "a8970ae9-ea63-ca26-6738-ffd796ba2fc3",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

Образ  docker не удаляется т.к. в описании  ресурса ```docker_image``` явно  указано хранить образ на локальной машине. Согласно  документцации:
```    keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.```