output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = try(data.kubernetes_service.app_service.status.0.load_balancer.0.ingress.0.ip, "")
}

output "deployment_name" {
  description = "The name of the Kubernetes deployment"
  value       = "app"
}