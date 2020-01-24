#
# Variables
#

variable "hcloud_token" {}

variable "username" {}

variable "sshkey_location" {}

#
# Resources
#

data "template_file" "sshkey" {
  template = "${file(var.sshkey_location)}"
}

#
# Server
#

module "server"{
  source = "./server"

  hcloud_token = "${var.hcloud_token}"

  username = "${var.username}"
  sshkey = "${data.template_file.sshkey.rendered}"
}

#
# Output
#

output "server_ipv4" {
  value = "${module.server.server_ipv4}"
}

output "server_ipv6" {
  value = "${module.server.server_ipv6}"
}