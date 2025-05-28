### Задание 1

1. 
2. Перхожу в консоль яндекса, выбираю облако, рядом с каталогом нажимаю "..." > "Создать сервисный аккаунт", после создания сервисного аккаунта захожу в него создаю и скачиваю "Авторизованный ключ", сохраняю в домашний каталог
3. 
4. В яндекс облаке нет platform_id (standard-v1 - Intel Cascade Lake, standard-v2 - Intel Ice Lake, standard-v3 - AMD EPYC), cores минимально 2.
5. 
6. ```core_fraction=5``` - базовая производительность ядра процессора
```preemptible = true``` - означаетс, что виртуальная машина будет работать не более 24 часов
Параметры нужны для снижение стоимости виртуальной машины

![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/02/1-1.png)
![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/02/1-2.png)

### Задание 2

![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/02/2-1.png)

### Задание 3

В vms_platform.tf создал 2 набора переменных для vm_web_ и vm_db_
В main.tf добавил вторую подсеть и вторую ВМ использую переменные vm_db_

### Задание 4

[outputs.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/02/src/outputs.tf)

### Задание 5

[locals.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/02/src/locals.tf)

### Задание 6
[vms_platform.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/02/src/vms_platform.tf)
[1.auto.tfvars](https://github.com/GlubuchikAr/ter-homeworks/blob/master/02/src/1.auto.tfvars)