resource "aws_instance" "wp-instance" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.small"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.wp-securitygroup.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  # user data
  user_data = "${data.template_cloudinit_config.cloudinit-wp.rendered}"

}

resource "aws_ebs_volume" "wp-data" {
    availability_zone = "eu-west-1a"
    size = 20
    type = "gp2" 
    tags {
        Name = "wp-data"
    }
}

resource "aws_volume_attachment" "wp-data-attachment" {
  device_name = "${var.INSTANCE_DEVICE_NAME}"
  volume_id = "${aws_ebs_volume.wp-data.id}"
  instance_id = "${aws_instance.wp-instance.id}"
}

