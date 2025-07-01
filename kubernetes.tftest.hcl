run "Create cluster" {
  command = plan

  assert {
    condition     = var.kubernetes_version_prefix != null
    error_message = "The cluster version is empty."
  }

  variables = {
    kubernetes_version_prefix = "1.22."
    cluster = [
      {
        id = 0
        name         = "foo"
        region       = "nyc1"
        auto_upgrade = true
        maintenance_policy = [
          {
            start_time = "04:00"
            day        = "sunday"
          }
        ]
        node_pool = [
          {
            name       = "default"
            size       = "s-1vcpu-2gb"
            node_count = 3
          }
        ]
      }
    ]
  }
}

run "create node_pool" {
  command = plan

  assert {
    condition = length([for a in var.node_pool : true if a.cluster_id != null]) == length(var.node_pool)
    error_message = "Cluster_id is empty."
  }

  variables = {
    kubernetes_cluster_name = "foo"
    labels = {
      service  = "backend"
      priority = "high"
    }
    node_pool = [
      {
        id = 0
        name       = "backend-pool"
        size       = "c-2"
        node_count = 2
        tags       = ["backend"]
        taint = [
          {
            key    = "workloadKind"
            value  = "database"
            effect = "NoSchedule"
          }
        ]
      }
    ]
  }
}