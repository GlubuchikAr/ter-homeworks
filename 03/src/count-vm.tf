resource "yandex_compute_instance" "web" {
  depends_on  = [yandex_compute_instance.db]
  count       = 2
  name        = "web-${count.index + 1}"
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