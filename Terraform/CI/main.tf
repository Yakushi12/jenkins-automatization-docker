provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

#-------Secret Manager-------#
module "secret_manager" {
  source = "./modules/secret_manager"

  project = var.project
  secret_pair = var.secret_pair
}


#-------Create Networking-------#
module "Networking" {
  source = "./modules/networking"

  project         = var.project
  region          = var.region
  networking_name = var.networking_name
  vpc_description = var.vpc_description
  routing_mode    = var.routing_mode
  ip_cidr_range   = var.ip_cidr_range
  fw_ports        = var.fw_ports
  fw_target_tags  = var.fw_target_tags
}

# -------Create CI Env-------#
module "instances" {
  source = "./modules/instances"

  zone                            = var.zone
  user                            = var.user
  images                          = var.images
  project                         = var.project
  #key_privat                      = var.key_privat
  fw_target_tags                  = module.Networking.fw_self_link
  instances_names                 = var.instances_names
  template_network                = module.Networking.net_self_link
  template_subnetwork             = module.Networking.subnet_self_link
  template_machine_type           = var.template_machine_type
  template_service_account_scopes = var.template_service_account_scopes
}
