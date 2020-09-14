provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

#-------Create MySql Database-------#
module "mysql" {
source  = "./modules/mysql"
project = var.project

#user
mysql_user_password = var.mysql_user_password
mysql_user_host     = var.mysql_user_host

#db
mysql_name                = var.mysql_name
mysql_database_version    = var.mysql_database_version
mysql_region              = var.mysql_region
mysql_tier                = var.mysql_tier
mysql_activation_policy   = var.mysql_activation_policy
mysql_authorized_networks = var.mysql_authorized_networks
}

#-------Create Instance Group-------#
module "instance_group" {
  source            = "./modules/instance_group"
  depends_on = [module.mysql]

  zone                                    = var.zone
  fw_target_tags                          = var.fw_target_tags
  template_network                        = var.template_network
  health_check_name                       = var.health_check_name
  health_check_port                       = var.health_check_port
  google_compute_name                     = var.google_compute_name
  template_subnetwork                     = var.template_subnetwork
  backend_timeout_sec                     = var.backend_timeout_sec
  template_machine_type                   = var.template_machine_type
  template_can_ip_forward                 = var.template_can_ip_forward
  health_check_interval_sec               = var.health_check_interval_sec
  google_compute_instance_image           = var.google_compute_instance_image
  template_service_account_scopes         = var.template_service_account_scopes
  template_scheduling_automatic_restart   = var.template_scheduling_automatic_restart
  template_scheduling_on_host_maintenance = var.template_scheduling_on_host_maintenance

}

#-------Create Load Balancer-------#
module "load_balancer" {
  source = "./modules/http_load_balancer"
  depends_on = [module.instance_group]

  lb_name                               = var.lb_name
  fw_network                            = var.template_network
  instance_group                        = module.instance_group.instance_group_manager_id
  backend_timeout_sec                   = var.backend_timeout_sec
  backend_balancing_mode                = var.backend_balancing_mode
  backend_capacity_scaler               = var.backend_capacity_scaler
  google_compute_health_check           = module.instance_group.google_compute_health_check
  google_compute_instance_group_manager = [module.instance_group.instance_group_scope]

}
