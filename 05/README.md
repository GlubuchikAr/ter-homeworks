### Задание 1
tflint
- Нет версии у провайдера.
- Переменные объявлены, но не используются.
- Исходный код модуля "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" использует ветку по умолчанию в качестве ссылки (main) (terraform_module_pinned_source)

checkov
- Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
- Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"

### Задание 2
Создал бакет, создал YDB, внес данные для подколючения в ~/.aws/credentials.

В [providers.tf](https://github.com/GlubuchikAr/ter-homeworks/blob/master/05/src/providers.tf) настроил хранение backend "s3" и dynamodb_table

![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/05/2-1.png)

игнорировать блокировку можно командой `terraform apply -lock=false`

разблокировать блокировку можно командой `terraform force-unlock ID_блокировки`
![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/05/2-2.png)

### Задание 3
https://github.com/GlubuchikAr/ter-homeworks/pull/5

### Задание 4
![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/05/4-1.png)
![](https://github.com/GlubuchikAr/ter-homeworks/blob/master/05/4-2.png)