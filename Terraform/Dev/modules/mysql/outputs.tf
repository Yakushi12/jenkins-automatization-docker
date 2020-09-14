output "instance_name" {
  value       = google_sql_database_instance.mysql.name
  description = "The instance name for the master instance"
}

output "instance_ip_address" {
  value       = google_sql_database_instance.mysql.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "instance_connection_name" {
  value       = google_sql_database_instance.mysql.connection_name
  description = "The connection name of the master instance to be used in connection strings"
}
