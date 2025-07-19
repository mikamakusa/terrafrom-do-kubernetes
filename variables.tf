## DATAS
variable "kubernetes_version_prefix" {
  type = string
}

## MAPS

variable "labels" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = list(string)
  default = []
}

## RESOURCES

variable "cluster" {
  type = list(object({
    id                               = any
    name                             = string
    region                           = string
    cluster_subnet                   = optional(string)
    service_subnet                   = optional(string)
    vpc_uuid                         = optional(string)
    auto_upgrade                     = optional(bool)
    surge_upgrade                    = optional(bool)
    ha                               = optional(bool)
    registry_integration             = optional(bool)
    destroy_all_associated_resources = optional(bool)
    tags                             = optional(list(string))
    cluster_autoscaler_configuration = optional(list(object({
      scale_down_utilization_threshold = optional(number)
      scale_down_unneeded_time         = optional(string)
    })), [])
    control_plane_firewall = optional(list(object({
      enabled           = bool
      allowed_addresses = list(string)
    })), [])
    maintenance_policy = optional(list(object({
      day        = string
      start_time = string
    })), [])
    node_pool = optional(list(object({
      name       = string
      size       = string
      node_count = optional(number)
      max_nodes  = optional(number)
      min_nodes  = optional(number)
      auto_scale = optional(bool)
      tags       = optional(list(string))
      labels     = optional(map(string))
      taint = optional(list(object({
        effect = string
        key    = string
        value  = string
      })), [])
    })), [])
    routing_agent = optional(list(object({
      enabled = bool
    })), [])
  }))
  default = []
}