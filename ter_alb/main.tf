
# VM attach

data "yandex_compute_image" "lemp" {
  family = var.family_vm_ig
}
data "template_file" "cloudinit" {
 template = file("./cc.yml")
  vars = {
    ssh_public_key     = file("~/.ssh/id_ed25519.pub")
  }
}