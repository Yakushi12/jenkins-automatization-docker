output "mysql_ip" {
  value       = module.mysql.instance_ip_address
  description = "an identifier for the resource with format projects/{{project}}/zones/{{zone}}/instanceGroupManagers/{{name}}"
}
output "frontend_ip" {
  value       = module.load_balancer.google_compute_global_address
  description = "an identifier for the resource with format projects/{{project}}/zones/{{zone}}/instanceGroupManagers/{{name}}"
}
