variable "web_provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}

resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",

  { webservers = yandex_compute_instance.web 
    dbservers = yandex_compute_instance.db
    storage = [yandex_compute_instance.storage]})

  filename = "${abspath(path.module)}/hosts.ini"
}

resource "null_resource" "web_hosts_provision" {
  count = var.web_provision == true ? 1 : 0
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.db, yandex_compute_instance.web, yandex_compute_instance.storage]

  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command    = "eval $(ssh-agent) && cat ~/.ssh/aglubuchik | ssh-add -"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/test.yml"
    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
  triggers = {
    always_run      = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
    always_run_uuid = "${uuid()}"
    # playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    # ssh_public_key = var.public_key # при изменении переменной with ssh
    # template_rendered = "${local_file.hosts_templatefile.content}" #при изменении inventory-template
    # password_change = jsonencode( {for k,v in random_password.each: k=>v.result})
  }
}
