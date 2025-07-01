data "digitalocean_kubernetes_versions" "this" {
  version_prefix = var.kubernetes_version_prefix
}

data "digitalocean_kubernetes_cluster" "this" {
  count = var.kubernetes_cluster_name ? 1 : 0
  name = var.kubernetes_cluster_name
}