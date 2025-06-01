### Задание 1
![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/1-1.png)

### Задание 2
1. [count-vm.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/count-vm.tf)
2. [for_each-vm.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/for_each-vm.tf)
3. В `count-vm.tf` добавил `depends_on = [yandex_compute_instance.db]`
4. [locals.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/locals.tf)
5. ![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/2-1.png)

### Задание 3
[disk_vm.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/disk_vm.tf)
![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/3-1.png)

### Задание 4
[ansible.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/ansible.tf)
[hosts.tftpl](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/hosts.tftpl)
[hosts.ini](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/hosts.ini)

### Задание 5* (необязательное)
Добавил ```output "info" ``` в `main.tf`
[main.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/main.tf)
![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/5-1.png)

### Задание 6* (необязательное)
1. [ansible.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/ansible.tf)
2. ```ansible_host=${i["network_interface"][0]["nat"] ? i["network_interface"][0]["nat_ip_address"] : i["network_interface"][0]["ip_address"]}```
[hosts.tftpl](https://github.com/GlubuchikAr/ter-homeworks/blob/master/03/src/hosts.tftpl)

### Задание 7* (необязательное)
