output "elb" {
  value = "${aws_elb.myapp-elb.dns_name}"
}
output "wp" {
  value = "${aws_instance.wp-instance.public_ip}"
}
output "myapp-repository-URL" {
  value = "${aws_ecr_repository.myapp.repository_url}"
}
