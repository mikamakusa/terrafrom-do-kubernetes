output "cluster" {
  description = "Informations relatives au cluster kubernetes."
  value = {
    for a in digitalocean_kubernetes_cluster.this : a => {
      id                   = a.id
      name                 = a.name
      region               = a.region
      endpoint             = a.endpoint
      version              = a.version
      status               = a.status
      service_subnet       = a.service_subnet
      cluster_subnet       = a.cluster_subnet
      urn                  = a.urn
      vpc_uuid             = a.vpc_uuid
      ipv4_address         = a.ipv4_address
      auto_upgrade         = a.auto_upgrade
      registry_integration = a.registry_integration
      surge_upgrade        = a.surge_upgrade
    }
  }
}

output "node_pool" {
  description = "Informations relatives au(x) node_pool(s)."
  value = {
    for b in digitalocean_kubernetes_node_pool.this : b => {
      id                = b.id
      name              = b.name
      taint             = b.taint
      tags              = b.tags
      labels            = b.labels
      cluster_id        = b.cluster_id
      size              = b.size
      actual_node_count = b.actual_node_count
      auto_scale        = b.auto_scale
      node_count        = b.node_count
      min_nodes         = b.min_nodes
      max_nodes         = b.max_nodes
    }
  }
}