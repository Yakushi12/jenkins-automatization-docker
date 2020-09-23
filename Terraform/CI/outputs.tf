output "jenkins_ip" {
  value       = module.instances.jenkins_nat_ip
  description = "an identifier for the resource with format projects/{{project}}/zones/{{zone}}/instanceGroupManagers/{{name}}"
}
output "nexus_ip" {
  value       = module.instances.nexus_nat_ip
  description = "an identifier for the resource with format projects/{{project}}/zones/{{zone}}/instanceGroupManagers/{{name}}"
}
