#
# Variables
#

variable "hcloud_token" {}
variable "username" {}

variable "sshkey" {}

#
# Data
#

data "template_file" "cloud-init-yaml" {
  template = "${file("${path.module}/cloud-init.yaml")}"
  vars = {
    username = var.username
    sshkey-admin = var.sshkey
  }
}

#
# Providers
#

provider "hcloud" {
  token = "${var.hcloud_token}"
}

#
# Server
#

resource "hcloud_server" "server" {
  name = "server"
  location = "fsn1"
  image = "ubuntu-18.04"
  backups = true

  # 1vCPU, 2GB RAM, 20GB NVMe SSD, 20TB Traffic
  server_type = "cx11"

  user_data = "${data.template_file.cloud-init-yaml.rendered}"

  #connection {
  #  type     = "ssh"
  #  user     = "${var.username}"
  #  host     = "${hcloud_server.server.ipv4_address}"
  #}

  #provisioner "remote-exec" {
  #  inline = [
  #    "echo changeme",
  #  ]
  #}

  # setup.sh
  #provisioner "file" {
  #  source      = "${path.module}/setup.sh"
  #  destination = "/project/setup.sh"
  #}
}

#
# Output
#

output "server_ipv4" {
  value = "${hcloud_server.server.ipv4_address}"
}

output "server_ipv6" {
  value = "${hcloud_server.server.ipv6_address}"
}