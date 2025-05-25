## Задание 1

1. Для скачивания всех зависимостей, выполняю комманду `terraform init` внутри дериктории с файлом .tf, необходимые провайдеры скачиваются в директорию ./.terraform
2. Секретную информацию можно хранить в файле personal.auto.tfvars, так же секретная информация может присутствовать в файлах с расширением .tfstate
3. Для выполнения кода проекта использую `terraform apply`, подтверждаю `yes`, создается файл `terraform.tfstate`, в нем внутри блока `resources > instances > attributes` записан пароль `"result": "6BiO8aGOrMzcHuqB"`
4. Ошибки:
    - `resource "docker_image"` пропущено уникальное имя в текущем проекте
    - `resource "docker_container" "1nginx"` Имя должно начинаться с буквы или символа подчеркивания и может содержать только буквы, цифры, знаки подчеркивания и тире
    - `name  = "example_${random_password.random_string_FAKE.resulT}"` обращаемся к ресурсу который не объявлен и к значению которое не выдается в этом расширении.
5. [Исправленный код](https://github.com/GlubuchikAr/ter-homeworks/blob/master/01/srt/main.tf) :
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx-1" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```
Запущенный контейнер:
```
docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
68e6f7b7ec3b   be69f2940aaf   "/docker-entrypoint.…"   12 seconds ago   Up 11 seconds   0.0.0.0:9090->80/tcp   example_6BiO8aGOrMzcHuqB
```
6. Флаг `-auto-approve` применяет изменения без подтверждения. 
Если были допущены ошибке в файле конфигурации то может случится что-то неожиданное. 
Может применять в автоматизации рабочих процессах не требующих взаимодействия с пользователем.
```
docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
de4af4ee9750   be69f2940aaf   "/docker-entrypoint.…"   3 seconds ago   Up 2 seconds   0.0.0.0:9090->80/tcp   hello_world
```
7. Для уничтожения ресурсов созданных с помощью terraform использую `terraform destroy`
содержимое файла **terraform.tfstate**
```
{
  "version": 4,
  "terraform_version": "1.9.8",
  "serial": 14,
  "lineage": "b88af759-b113-3c25-dacf-f68a60f98126",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
8. `keep_locally = true` означает, что образ будет сохранен локально и не будет удаляться командой `terraform destroy`
```
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
```




## Задание 2
1. Создал через `console.yandex.cloud`
2. Установил docker и добавил пользователся в группу docker
3. Для подключения к удаленному docker, нужно насроить конфигурацию провайдера
```
provider "docker" {
  host     = "ssh://user@remote-host:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}
```
4. и 6. [Финальный код](https://github.com/GlubuchikAr/ter-homeworks/blob/master/01/2/main.tf)
```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=1.8.4" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {
  host     = "ssh://glubuchik@89.169.139.137:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

#однострочный комментарий

resource "random_password" "random_string-1" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "random_string-2" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
}

resource "docker_container" "mysql-1" {
  image = docker_image.mysql.image_id
  name  = "mysql"

  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.random_string-1.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.random_string-2.result}",
    "MYSQL_ROOT_HOST=\"%\""
  ]
}
```
![env](https://github.com/GlubuchikAr/ter-homeworks/blob/master/01/2/env.png)