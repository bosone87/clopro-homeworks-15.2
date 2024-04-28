
# O

output "external_load_balancer_ip" {
  value = yandex_alb_load_balancer.load-balancer.listener[0].endpoint[0].address[0].external_ipv4_address
}
/* output "external_load_balancer_ip_subnet_b" {
  value = yandex_alb_load_balancer.load-balancer["sub-b"].listener[0].endpoint[0].address[0].external_ipv4_address
}
output "external_load_balancer_ip_subnet_d" {
  value = yandex_alb_load_balancer.load-balancer["sub-d"].listener[0].endpoint[0].address[0].external_ipv4_address
} */

output "bucket_domain_name" {
  value = "http://${yandex_storage_bucket.pictures-bucket.bucket_domain_name}/picture-tlz-1.jpg"
}