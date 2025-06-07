terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.8.4"
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
# Задание 2
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.cidr
}


# Задание 4
# resource "yandex_vpc_subnet" "develop" {
#   for_each = { for i in var.subnets : i.zone => i }
#   name           = "${var.vpc_name}-${replace(replace(each.value.cidr, "/", "-"), ".","-")}"
#   zone           = each.value.zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = [each.value.cidr]
# }