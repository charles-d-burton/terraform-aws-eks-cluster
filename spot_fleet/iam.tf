# Create the IAM Roles
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.service_name}-${var.region}"
  role = "${aws_iam_role.spot_instance_role.name}"
}

resource "aws_iam_role" "spot_fleet_role" {
  name = "${var.service_name}-${var.region}-fleet"

  assume_role_policy = "${data.aws_iam_policy_document.spot_fleet_role_policy.json}"
}

resource "aws_iam_role" "spot_instance_role" {
  name = "${var.service_name}-${var.region}-instance"

  assume_role_policy = "${data.aws_iam_policy_document.spot_instance_role_policy.json}"
}

resource "aws_iam_policy" "autoscaling_policy" {
  name   = "autoscaling-${var.service_name}-${var.region}"
  policy = "${data.aws_iam_policy_document.spot_fleet_autoscaling_policy.json}"
}

resource "aws_iam_role" "autoscaling_role" {
  name               = "tf-autoscaling-${var.service_name}-${var.region}"
  assume_role_policy = "${data.aws_iam_policy_document.spot_fleet_autoscaling_role.json}"
}

resource "aws_iam_policy_attachment" "autoscaling_attachment" {
  name       = "tf-${var.service_name}-${var.env}-${var.region}"
  policy_arn = "${aws_iam_policy.autoscaling_policy.arn}"
  roles      = ["${aws_iam_role.autoscaling_role.name}"]
}

#Create the IAM Policies
resource "aws_iam_policy" "spot_fleet_policy" {
  name   = "${var.service_name}-fleet-${var.region}"
  policy = "${data.aws_iam_policy_document.spot_fleet_policy.json}"
}

resource "aws_iam_policy" "spot_instance_policy" {
  name   = "${var.service_name}-instance-${var.region}"
  policy = "${data.aws_iam_policy_document.spot_fleet_instance_policy.json}"
}

#Attach policies to roles
resource "aws_iam_policy_attachment" "fleet_attachment" {
  name       = "${var.service_name}-attach"
  policy_arn = "${aws_iam_policy.spot_fleet_policy.arn}"
  roles      = ["${aws_iam_role.spot_fleet_role.name}"]
}

resource "aws_iam_policy_attachment" "instance_attachment" {
  name       = "${var.service_name}-instance-attach"
  policy_arn = "${aws_iam_policy.spot_instance_policy.arn}"
  roles      = ["${aws_iam_role.spot_instance_role.name}"]
}

resource "aws_iam_policy_attachment" "extra_attach" {
  count      = "${length(var.instance_policy_arns)}"
  name       = "${var.service_name}-extra-attach-${count.index}"
  policy_arn = "${var.instance_policy_arns[count.index]}"
  roles      = ["${aws_iam_role.spot_instance_role.name}"]
}
