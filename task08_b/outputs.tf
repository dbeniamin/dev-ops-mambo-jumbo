output "redis_fqdn" {
  description = "The FQDN of Redis in Azure Container Instance"
  value       = module.aci_redis.redis_fqdn
}

output "aca_fqdn" {
  description = "The FQDN of App in Azure Container App"
  value       = module.aca.container_app_fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of APP in AKS"
  value       = module.k8s.load_balancer_ip
}