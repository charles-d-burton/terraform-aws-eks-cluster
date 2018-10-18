output "instance_role" {
  value = "${aws_iam_role.spot_instance_role.arn}"
}
