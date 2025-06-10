module "vpc" {
  source       = "./vpc"
  vpc_name     = "develop"
  subnets = [
    { zone = var.default_zone, cidr = var.default_cidr },
  ]
}

module "security_group_web" {
  source        = "./security"
  security_name = "securitsecurity_group_weby_group"
  network       = module.vpc.network[0].id
  folder_id     = var.folder_id
}

module "security_group_db" {
  source                 = "./security"
  security_name          = "security_group_db"
  network                = module.vpc.network[0].id
  folder_id              = var.folder_id
  security_group_ingress = var.security_group_ingress_db
  security_group_egress  = var.security_group_egress_db
}

module "mysql_db" {
  source = "./mysql"

  cluster_name        = "internal-mysql-db"
  environment         = "PRODUCTION"
  network_id          = module.vpc.network[0].id
  security_group_ids  = [module.security_group_db.security_group[0].id]
  
  zones               = var.default_zone
  subnets             = [module.vpc.subnet[0].ru-central1-a.id]
  allowed_subnet_cidr = [module.vpc.subnet[0].ru-central1-a.id]

  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
}

data "cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("./cloud-init.yml", {
      ssh_public_key = file("~/.ssh/aglubuchik.pub")
      mysql_database = var.db_name
      mysql_host     = module.mysql_db.hosts[0]
      mysql_user     = var.db_user
      mysql_password = var.db_password
    })
  }
}

module "project" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab"
  env_name       = "project" 
  network_id     = module.vpc.network[0].id
  subnet_zones   = var.default_zone
  subnet_ids     = [module.vpc.subnet[0].ru-central1-a.id]
  instance_name  = "project"
  instance_count = 1
  image_family   = var.vm_family
  public_ip      = true
  security_group_ids = [module.security_group_web.security_group[0].id]

  labels = { 
    owner= "a.glubuchik",
    project = "project"
     }

  metadata = {
    user-data          = data.cloudinit_config.config.rendered
    serial-port-enable = 1
  }
}


resource "yandex_container_registry" "registry" {
  name      = var.registry_name
  folder_id = var.folder_id
}

resource "yandex_container_repository" "repositories" {  
  name = "${yandex_container_registry.registry.id}/backend"
}




