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
```
merge(
local.vpc, 
{ 
subnet_ids = concat(
slice(local.vpc.subnet_ids, 0, 2),
slice(local.vpc.subnet_ids, 3, length(local.vpc.subnet_ids))),
subnet_zones = concat( slice(local.vpc.subnet_zones, 0, 2),
slice(local.vpc.subnet_zones, 3, length(local.vpc.subnet_zones)))
})
```
```
merge(local.vpc, {
  subnet_ids   = [for i, x in local.vpc.subnet_ids : x if i != 2],
  subnet_zones = [for i, x in local.vpc.subnet_zones : x if i != 2]
})
```

### Задание 8* (необязательное)
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"]} platform_id=${i["platform_id"]}
%{~ endfor ~}
```

### Задание 9* (необязательное)
[ for i in range(1, 97) : format("rc%02d", i) if !contains([0,7,8,9], i % 10) || i == 19 ]
  