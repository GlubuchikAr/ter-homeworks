resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_family
}

output "info" {
  value = {
    webservers = [
    for web in yandex_compute_instance.web : {
      name = web.name
      id   = web.id
      fqdn = web.fqdn
    }
  ],
    dbervers = [
    for db in yandex_compute_instance.db : {
      name = db.name
      id   = db.id
      fqdn = db.fqdn
    }
  ],
    storage = [
    for storage in [yandex_compute_instance.storage] : {
      name = storage.name
      id   = storage.id
      fqdn = storage.fqdn
    }
  ]
  }
}
