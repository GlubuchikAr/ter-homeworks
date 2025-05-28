output "test" {

  value = [
    { platform-1 = [yandex_compute_instance.platform-1.name, yandex_compute_instance.platform-1.network_interface[0].nat_ip_address, yandex_compute_instance.platform-1.network_interface[0].ip_address, yandex_compute_instance.platform-1.fqdn] },
    { platform-2 = [yandex_compute_instance.platform-2.name, yandex_compute_instance.platform-2.network_interface[0].nat_ip_address, yandex_compute_instance.platform-2.network_interface[0].ip_address, yandex_compute_instance.platform-2.fqdn] },

  ]
}