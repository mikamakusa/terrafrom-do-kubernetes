## Requirements

| Name | Version    |
|------|------------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | \>= 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_kubernetes_node_pool.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_node_pool) | resource |
| [digitalocean_kubernetes_versions.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>list(object({<br/>    id                               = any<br/>    name                             = string<br/>    region                           = string<br/>    cluster_subnet                   = optional(string)<br/>    service_subnet                   = optional(string)<br/>    vpc_uuid                         = optional(string)<br/>    auto_upgrade                     = optional(bool)<br/>    surge_upgrade                    = optional(bool)<br/>    ha                               = optional(bool)<br/>    registry_integration             = optional(bool)<br/>    destroy_all_associated_resources = optional(bool)<br/>    tags                             = optional(list(string))<br/>    cluster_autoscaler_configuration = optional(list(object({<br/>      scale_down_utilization_threshold = optional(number)<br/>      scale_down_unneeded_time         = optional(string)<br/>    })), [])<br/>    control_plane_firewall = optional(list(object({<br/>      enabled           = bool<br/>      allowed_addresses = list(string)<br/>    })), [])<br/>    maintenance_policy = optional(list(object({<br/>      day        = string<br/>      start_time = string<br/>    })), [])<br/>    node_pool = optional(list(object({<br/>      name       = string<br/>      size       = string<br/>      node_count = optional(number)<br/>      max_nodes  = optional(number)<br/>      min_nodes  = optional(number)<br/>      auto_scale = optional(bool)<br/>      tags       = optional(list(string))<br/>      labels     = optional(map(string))<br/>      taint = optional(list(object({<br/>        effect = string<br/>        key    = string<br/>        value  = string<br/>      })), [])<br/>    })), [])<br/>    routing_agent = optional(list(object({<br/>      enabled = bool<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_kubernetes_version_prefix"></a> [kubernetes\_version\_prefix](#input\_kubernetes\_version\_prefix) | # DATAS | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | Informations relatives au cluster kubernetes. |
| <a name="output_node_pool"></a> [node\_pool](#output\_node\_pool) | Informations relatives au(x) node\_pool(s). |
