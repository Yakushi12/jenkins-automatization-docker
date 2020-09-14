output "instances_ip" {
  value       = module.instances.instance_nat_ip
  description = "an identifier for the resource with format projects/{{project}}/zones/{{zone}}/instanceGroupManagers/{{name}}"
}
