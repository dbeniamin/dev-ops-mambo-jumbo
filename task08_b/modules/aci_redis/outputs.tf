output "redis_fqdn" {
  description = "The FQDN of the Redis container instance"
  value       = azurerm_container_group.redis.fqdn
}

output "redis_ip" {
  description = "The IP address of the Redis container instance"
  value       = azurerm_container_group.redis.ip_address
}

output "redis_password" {
  description = "The password for Redis database"
  value       = random_password.redis_password.result
  sensitive   = true
}