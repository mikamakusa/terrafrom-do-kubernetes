data "digitalocean_kubernetes_versions" "this" {
  version_prefix = var.kubernetes_version_prefix
}