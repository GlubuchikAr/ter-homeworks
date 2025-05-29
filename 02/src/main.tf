resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}
resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vm_db_subnet_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "test-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform-1" {
  name        = local.name_vm_web
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.instance_resources.web.cores
    memory        = var.instance_resources.web.memory
    core_fraction = var.instance_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_web_disk_type
      size     = var.vm_web_disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_scheduling_policy
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_network_interface_nat
  }

  metadata = {
    serial-port-enable = var.instance_metadata.web.serial-port-enable
    ssh-keys           = var.instance_metadata.web.ssh-keys
  }

}

resource "yandex_compute_instance" "platform-2" {
  name        = local.name_vm_db
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.instance_resources.db.cores
    memory        = var.instance_resources.db.memory
    core_fraction = var.instance_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_db_disk_type
      size     = var.vm_db_disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_scheduling_policy
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vm_db_network_interface_nat
  }
  metadata = {
    serial-port-enable = var.instance_metadata.db.serial-port-enable
    ssh-keys           = var.instance_metadata.db.ssh-keys
  }
  zone = var.vm_db_zone
}