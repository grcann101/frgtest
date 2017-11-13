provider "cloudinit" {}

data "template_file" "wp-init" {
  template = "${file("scripts/wp-init.sh")}"
  vars {
    DEVICE = "${var.INSTANCE_DEVICE_NAME}"
    WP_VERSION = "${var.WP_VERSION}"
  }
}
data "template_cloudinit_config" "cloudinit-wp" {

  gzip = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.wp-init.rendered}"
  }

}
