output "security_group" {
  value = yandex_vpc_security_group.security_group[*]
}
