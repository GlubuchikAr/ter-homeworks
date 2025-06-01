resource "yandex_compute_disk" "disk" {
  count = 3
  name     = "storage-disk-${count.index + 1}"
  type     = var.disk.disk_type
  size     = var.disk.disk_size
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vm_platform_id
  resources {
    cores         = var.instance_resources.default.cores
    memory        = var.instance_resources.default.memory
    core_fraction = var.instance_resources.default.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.instance_resources.default.disk_type
      size     = var.instance_resources.default.disk_size
    }
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
      disk_id = lookup(secondary_disk.value, "id", null)
    }
  }
  scheduling_policy {
    preemptible = var.instance_resources.default.preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.instance_resources.default.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = {
    serial-port-enable = var.instance_resources.default.serial-port-enable
    ssh-keys           = local.ssh-keys
  }
}