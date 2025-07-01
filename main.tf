resource "digitalocean_kubernetes_cluster" "this" {
  count                            = length(var.cluster)
  name                             = lookup(var.cluster[count.index], "name")
  region                           = lookup(var.cluster[count.index], "region")
  version                          = data.digitalocean_kubernetes_versions.this.latest_version
  cluster_subnet                   = lookup(var.cluster[count.index], "cluster_subnet")
  service_subnet                   = lookup(var.cluster[count.index], "service_subnet")
  vpc_uuid                         = lookup(var.cluster[count.index], "vpc_uuid")
  auto_upgrade                     = lookup(var.cluster[count.index], "auto_upgrade")
  surge_upgrade                    = lookup(var.cluster[count.index], "surge_upgrade")
  ha                               = lookup(var.cluster[count.index], "ha")
  registry_integration             = lookup(var.cluster[count.index], "registry_integration")
  destroy_all_associated_resources = lookup(var.cluster[count.index], "destroy_all_associated_resources")
  tags                             = lookup(var.cluster[count.index], "tags")

  dynamic "cluster_autoscaler_configuration" {
    for_each = try(lookup(var.cluster[count.index], "cluster_autoscaler_configuration") == null ? [] : ["cluster_autoscaler_configuration"])
    content {
      scale_down_utilization_threshold = lookup(cluster_autoscaler_configuration.value, "scale_down_utilization_threshold")
      scale_down_unneeded_time         = lookup(cluster_autoscaler_configuration.value, "scale_down_unneeded_time")
    }
  }

  dynamic "control_plane_firewall" {
    for_each = try(lookup(var.cluster[count.index], "control_plane_firewall") == null ? [] : ["control_plane_firewall"])
    content {
      enabled           = lookup(control_plane_firewall.value, "enabled")
      allowed_addresses = lookup(control_plane_firewall.value, "allowed_addresses")
    }
  }

  dynamic "maintenance_policy" {
    for_each = try(lookup(var.cluster[count.index], "maintenance_policy") == null ? [] : ["maintenance_policy"])
    content {
      day        = lookup(maintenance_policy.value, "day")
      start_time = lookup(maintenance_policy.value, "start_time")
    }
  }

  dynamic "node_pool" {
    for_each = try(lookup(var.cluster[count.index], "node_pool") == null ? [] : ["node_pool"])
    content {
      name       = lookup(node_pool.value, "name")
      size       = lookup(node_pool.value, "size")
      node_count = lookup(node_pool.value, "node_count")
      max_nodes  = lookup(node_pool.value, "max_nodes")
      min_nodes  = lookup(node_pool.value, "min_nodes")
      auto_scale = lookup(node_pool.value, "auto_scale")
      tags       = lookup(node_pool.value, "tags")
      labels     = merge(
        var.labels,
        lookup(node_pool.value, "labels")
      )
    }
  }

  dynamic "routing_agent" {
    for_each = try(lookup(var.cluster[count.index], "routing_agent") == null ? [] : ["routing_agent"])
    content {
      enabled = lookup(routing_agent.value, "enabled")
    }
  }
}

resource "digitalocean_kubernetes_node_pool" "this" {
  count      = (length(var.cluster) || var.kubernetes_cluster_name) == 0 ? 0 : length(var.node_pool)
  cluster_id = try(var.kubernetes_cluster_name ? digitalocean_kubernetes_cluster.this.id : element(digitalocean_kubernetes_cluster.this.*.id, lookup(var.node_pool[count.index], "cluster_id")))
  name       = lookup(var.node_pool[count.index], "name")
  size       = lookup(var.node_pool[count.index], "size")
  node_count = lookup(var.node_pool[count.index], "node_count")
  min_nodes  = lookup(var.node_pool[count.index], "min_nodes")
  max_nodes  = lookup(var.node_pool[count.index], "max_nodes")
  auto_scale = lookup(var.node_pool[count.index], "auto_scale")
  tags       = lookup(var.node_pool[count.index], "tags")
  labels     = merge(
    var.labels,
    lookup(var.node_pool[count.index], "labels")
  )

  dynamic "taint" {
    for_each = try(lookup(var.node_pool[count.index], "taint") == null ? [] : ["taint"])
    content {
      effect = lookup(taint.value, "effect")
      key    = lookup(taint.value, "key")
      value  = lookup(taint.value, "value")
    }
  }
}