resource "yandex_alb_http_router" "router" {
    name      = "http-router"
}
resource "yandex_alb_virtual_host" "virtual-host" {
  name      = "virtual-host"
  http_router_id = yandex_alb_http_router.router.id
  route {
    name = "route-1"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend-group.id
        timeout = "3s"
      }
    }
  }
}
resource "yandex_alb_backend_group" "backend-group" {
  depends_on = [ yandex_compute_instance_group.ig-1 ]
  name      = "backend-group"

  http_backend {
    name = "http-backend"
    weight = 1
    port = 80
    target_group_ids = [ yandex_compute_instance_group.ig-1[0].application_load_balancer[0].target_group_id ]

    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout = "1s"
      interval = "1s"
      healthcheck_port = 80
      http_healthcheck {
        path  = "/"
      }
    }
  }
}
resource "yandex_alb_load_balancer" "load-balancer" {
  depends_on = [ yandex_compute_instance_group.ig-1 ]
  #for_each = var.subnets
  name        = "load-balancer"
  network_id  = yandex_vpc_network.network.id
  
  allocation_policy {
    location {
      zone_id   = "${lookup(var.subnets["sub-a"],"zone")}"
      subnet_id = "${yandex_vpc_subnet.public["sub-a"].id}"
    }
    location {
      zone_id   = "${lookup(var.subnets["sub-b"],"zone")}"
      subnet_id = "${yandex_vpc_subnet.public["sub-b"].id}"
    }
    location {
      zone_id   = "${lookup(var.subnets["sub-d"],"zone")}"
      subnet_id = "${yandex_vpc_subnet.public["sub-d"].id}"
    }
  }
  
  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 8080 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.router.id
      }
    }
  }
}
