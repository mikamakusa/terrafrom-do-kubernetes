## digitalocean_kubernetes_cluster
output "digitalocean_kubernetes_cluster_id" {
  value = try(digitalocean_kubernetes_cluster.this.*.id)
}

output "digitalocean_kubernetes_cluster_name" {
  value = try(digitalocean_kubernetes_cluster.this.*.name)
}

output "digitalocean_kubernetes_cluster_maintenance_policy" {
  value = try(digitalocean_kubernetes_cluster.this.*.maintenance_policy)
}

output "digitalocean_kubernetes_cluster_tags" {
  value = try(digitalocean_kubernetes_cluster.this.*.tags)
}

output "digitalocean_kubernetes_cluster_subnet" {
  value = try(digitalocean_kubernetes_cluster.this.*.cluster_subnet)
}

output "digitalocean_kubernetes_cluster_service_subnet" {
  value = try(digitalocean_kubernetes_cluster.this.*.service_subnet)
}

## digitalocean_kubernetes_node_pool
output "digitalocean_kubernetes_node_pool_id" {
  value = try(digitalocean_kubernetes_node_pool.this.*.id)
}

output "digitalocean_kubernetes_node_pool_name" {
  value = try(digitalocean_kubernetes_node_pool.this.*.name)
}

output "digitalocean_kubernetes_node_pool_taint" {
  value = try(digitalocean_kubernetes_node_pool.this.*.taint)
}

output "digitalocean_kubernetes_node_pool_tags" {
  value = try(digitalocean_kubernetes_node_pool.this.*.tags)
}

output "digitalocean_kubernetes_node_pool_labels" {
  value = try(digitalocean_kubernetes_node_pool.this.*.labels)
}
