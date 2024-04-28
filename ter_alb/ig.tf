
# Instance group

resource "yandex_compute_instance_group" "ig-1" {
    depends_on = [ yandex_resourcemanager_folder_iam_member.ig-editor ]

    for_each = {for key, value in var.vms: key => value}
    name                = each.value.name
    folder_id           = var.folder_id
    service_account_id  = yandex_iam_service_account.sa4ig.id
    instance_template {
        platform_id = each.value.platform_id
        resources {
            cores         = each.value.cpu
            memory        = each.value.ram
            core_fraction = each.value.cf
        }
        boot_disk {
            mode = "READ_WRITE"
            initialize_params {
                image_id = data.yandex_compute_image.lemp.image_id
                size     = each.value.disk
                type     = each.value.type
            }
        }
        network_interface {
            network_id  = yandex_vpc_network.network.id
            subnet_ids  = [ 
                yandex_vpc_subnet.public["sub-a"].id,
                yandex_vpc_subnet.public["sub-b"].id,
                yandex_vpc_subnet.public["sub-d"].id 
                ]
            nat = true
        }
        scheduling_policy {
            preemptible = true
        }
        metadata = local.metadata
    }    
    scale_policy {
        fixed_scale {
            size = 3
        }
    }
    allocation_policy {
        zones = [ 
            "${lookup(var.subnets["sub-a"],"zone")}",
            "${lookup(var.subnets["sub-b"],"zone")}",
            "${lookup(var.subnets["sub-d"],"zone")}"
             ]
    }
    deploy_policy {
        max_unavailable  = 2
        max_creating     = 3
        max_expansion    = 3
        max_deleting     = 2
    }
    application_load_balancer {
        target_group_name = "target-group"
  }

}