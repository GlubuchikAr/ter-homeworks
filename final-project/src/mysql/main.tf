terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.142.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
  required_version = ">1.8.4"
}

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "yandex_mdb_mysql_cluster" "mysql" {
  name                = var.cluster_name
  environment         = var.environment
  network_id          = var.network_id
  version             = var.mysql_version
  deletion_protection = var.deletion_protection
  security_group_ids  = var.security_group_ids

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type
    disk_size          = var.disk_size
  }

  dynamic "host" {
    for_each = var.ha ? [
      { zone = var.zones[0], subnet_id = var.subnets },
      { zone = var.zones[1], subnet_id = var.subnets }
    ] : [
      { zone = var.zones[0], subnet_id = var.subnets }
    ]
    assign_public_ip = var.assign_public
  }
}

resource "yandex_mdb_mysql_database" "db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "admin" {
  cluster_id = yandex_mdb_mysql_cluster.mysql
  name       = var.db_user
  password   = var.db_password == null ? random_password.random_string-1.result : var.db_password
  permission {
    database_name = var.db_name
    roles         = ["ALL"]
  }
}