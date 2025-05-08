output "name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "kube_config_raw" {
  description = "Raw Kubernetes client configuration"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "The Kubernetes cluster server host"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.host
}

output "username" {
  description = "The admin username for the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.username
  sensitive   = true
}

output "password" {
  description = "The admin password for the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.password
  sensitive   = true
}

output "client_certificate" {
  description = "The client certificate for authenticating to the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "The client key for authenticating to the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The CA certificate for the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate
}

output "kubeconfig" {
  description = "The full kubeconfig"
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
}

output "identity" {
  description = "The identity information for the cluster"
  value       = azurerm_kubernetes_cluster.this.identity
}