resource "digitalocean_kubernetes_cluster" "this" {
  for_each                         = { for a in var.cluster : a.name => a }
  name                             = join("-", [each.value.name, "cluster"])
  region                           = each.value.region
  version                          = data.digitalocean_kubernetes_versions.this.latest_version
  cluster_subnet                   = each.value.cluster_subnet
  service_subnet                   = each.value.service_subnet
  vpc_uuid                         = each.value.vpc_uuid
  auto_upgrade                     = each.value.auto_upgrade
  surge_upgrade                    = each.value.surge_upgrade
  ha                               = each.value.ha
  registry_integration             = each.value.registry_integration
  destroy_all_associated_resources = each.value.destroy_all_associated_resources
  tags                             = each.value.tags

  dynamic "cluster_autoscaler_configuration" {
    for_each = { for b in var.cluster : b.name => b if contains(keys(b), "cluster_autoscaler_configuration") && b.cluster_autoscaler_configuration != null }
    iterator = autoscaler
    content {
      scale_down_utilization_threshold = lookup(autoscaler.value, "scale_down_utilization_threshold")
      scale_down_unneeded_time         = lookup(autoscaler.value, "scale_down_unneeded_time")
    }
  }

  dynamic "control_plane_firewall" {
    for_each = { for c in var.cluster : c.name => c if contains(keys(c), "control_plane_firewall") && c.control_plane_firewall != null }
    iterator = firewall
    content {
      enabled           = lookup(firewall.value, "enabled")
      allowed_addresses = lookup(firewall.value, "allowed_addresses")
    }
  }

  dynamic "maintenance_policy" {
    for_each = { for d in var.cluster : d.name => d if contains(keys(d), "maintenance_policy") && d.maintenance_policy != null }
    iterator = maintenance
    content {
      day        = lookup(maintenance.value, "day")
      start_time = lookup(maintenance.value, "start_time")
    }
  }

  dynamic "node_pool" {
    for_each = { for e in var.cluster : e.name => e if contains(keys(e), "node_pool") && e.node_pool != null }
    content {
      name       = join("-", [lookup(node_pool.value, "name"), "pool"])
      size       = lookup(node_pool.value, "size")
      node_count = lookup(node_pool.value, "node_count")
      min_nodes  = lookup(node_pool.value, "min_nodes")
      max_nodes  = lookup(node_pool.value, "max_nodes")
      auto_scale = lookup(node_pool.value, "auto_scale")
      tags       = concat(var.tags, lookup(node_pool.value, "tags"))
      labels     = merge(var.labels, lookup(node_pool.value, "labels"))
    }
  }

  dynamic "routing_agent" {
    for_each = { for f in var.cluster : f.name => f if contains(keys(f), "routing_agent") && f.routing_agent != null }
    content {
      enabled = lookup(routing_agent.value, "enabled")
    }
  }
}

resource "digitalocean_kubernetes_node_pool" "this" {
  for_each   = { for g in var.cluster : g.name => g if contains(keys(g), "node_pool") && g.node_pool != null }
  cluster_id = digitalocean_kubernetes_cluster.this[each.key].id
  name       = join("-", [lookup(each.value, "name"), "pool"])
  size       = lookup(each.value, "size")
  node_count = lookup(each.value, "node_count")
  min_nodes  = lookup(each.value, "min_nodes")
  max_nodes  = lookup(each.value, "max_nodes")
  auto_scale = lookup(each.value, "auto_scale")
  tags       = concat(var.tags, lookup(each.value, "tags"))
  labels = merge(
    var.labels,
    lookup(each.value, "labels")
  )

  dynamic "taint" {
    for_each = { for g in var.cluster[0].node_pool : g.name => g if contains(keys(g), "taint") && g.taint != null }
    content {
      effect = lookup(taint.value, "effect")
      key    = lookup(taint.value, "key")
      value  = lookup(taint.value, "value")
    }
  }
}