### Версия установленного terraform

![Screenshot 2024-10-30 155047](https://github.com/user-attachments/assets/ffd8717e-d155-40ce-831e-61ec8efb55aa)

## Задание 1

### Пункт 2

Логины,пароли,ключи,токены итд, судя по gitignore, будем хранить в personal.auto.tfvars. А так-же сгенерированные терраформом пароли могут проскальзывать в .tfstate файлах.

### Пункт 3

Cекретное содержимое созданного ресурса random_password

"result": "9I8fijfVDWdzfB3R",

### Пункт 4

"1nginx" name не может начинаться с цифр

Переменная random_password.random_string_FAKE.resulT написана с ошибками. мы не задавали имя random_string_FAKE в resource "random_password", а так-же в переменной resulT допущена синтаксическая ошибка. Правильное написание переменных наглядно можно увидеть в файле terraform.tfstate в виде ключей и значений

resource "docker_container" не сможет найти image, который мы указали ему в качесте переменных из resource "docker_image", ведь мы его не раскомментировали (он выше 29 строки). Плюсом ко всему в resource "docker_image" следует указать имя, которое мы указали в качестве переменной в resource "docker_container"

### Пункт 5

[Исправленный код (ссылка на github)](https://github.com/gaidarvu/ter-homeworks/blob/main/01/src/main.tf)

![alt text](image.png)

### Пункт 6

При выполнении команды terraform apply с флагом -auto-approve может привести к неожиданным последствиям. Этот флаг автоматически одобряет все изменения, которые terraform собирается внести. Выполняя команду с данным флагом, мы должны чётко понимать какие изменения последуют после выполнения кода. В противном случае есть большая вероятность случайных изменений или удалений ресурсов. В любом случае лучше применять конфигурацию с подтверждением ручного ввода без флага -auto-approve или перед выполнением кода сделать terraform plan

Данный флаг может быть полезен тем, что убирает необходимость ручного подтверждения, команда будет выполняться быстрее. Это полезно в разработческих средах или в тестовых пайплайнах, где скорость является важным фактором. В некоторых случаях развертывание может быть заранее запланировано и протестировано. Использование -auto-approve может быть частью четкого процесса, где все изменения уже были проверены, и нет необходимости в дополнительных подтверждениях.

![alt text](image-1.png)

### Пункт 7

Cодержимое файла terraform.tfstate

```js
{
  "version": 4,
  "terraform_version": "1.9.8",
  "serial": 11,
  "lineage": "8eb799a7-e4ab-2dad-4396-1f2911fa3e5f",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

### Пункт 8

В resource "docker_image" мы явно указали значение keep_locally = true. Это значит что после завершения работы с ресурсом имадж Docker должен оставаться на локальной машине, а не удаляться автоматически.

Цитата от провайдера docker: 
>keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.

## Задание 2

[Финальный код main.tf (ссылка на github)](https://github.com/gaidarvu/ter-homeworks/blob/main/01/src_ycloud/main.tf)

![alt text](image-3.png)