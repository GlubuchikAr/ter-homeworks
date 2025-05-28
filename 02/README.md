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

### Задание 7
1. ``` > local.test_list[1]
"staging"```
2. 
``` > length(local.test_list)
3
```
3. 
``` > local.test_map["admin"]
"John"
```
4. 
``` "${local.test_map.admin} is ${[for key, value in local.test_map : key if value == "John"][0]} for production server based on OS ${local.servers.production.image} with ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks"
"John is admin for production server based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 virtual disks" 
```

### Задание 8

1. 
```
variable "test" {
  type = list(map(list(string)))
  default = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
}
```
2. ```> var.test[0].dev1[0]
"ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"```

### Задание 9