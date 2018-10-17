data "aws_caller_identity" "current" {}

#Policy document for the entire spot fleet cluster to assume the spot fleet role
data "aws_iam_policy_document" "spot_fleet_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "spotfleet.amazonaws.com",
        "ec2.amazonaws.com",
      ]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

#Policy for the spot fleet instances to assume the ec2 role
data "aws_iam_policy_document" "spot_instance_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

#Define the policies for the entire cluster allowing it to communicate with the spot fleet
data "aws_iam_policy_document" "spot_fleet_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeImages",
      "ec2:DescribeSubnets",
      "ec2:RequestSpotInstances",
      "ec2:TerminateInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:CancelSpotFleetRequests",
      "ec2:DescribeSpotFleetInstances",
      "ec2:DescribeSpotFleetRequests",
      "ec2:DescribeSpotFleetRequestHistory",
      "ec2:ModifySpotFleetRequest",
      "ec2:RequestSpotFleet",
      "iam:PassRole",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]

    resources = [
      "*",
    ]
  }
}

#Define the policy document for the instances attached to the spot fleet
data "aws_iam_policy_document" "spot_fleet_instance_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeInstanceStatus",
      "ec2:CancelSpotFleetRequests",
      "ec2:DescribeSpotFleetInstances",
      "ec2:DescribeSpotFleetRequests",
      "ec2:DescribeSpotFleetRequestHistory",
      "ec2:ModifySpotFleetRequest",
      "ec2:RequestSpotFleet",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
    ]

    resources = [
      "*",
    ]
  }
}

#Policy to allow the cluster to autoscale
data "aws_iam_policy_document" "spot_fleet_autoscaling_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeSpotFleetRequests",
      "ec2:ModifySpotFleetRequest",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
    ]

    resources = [
      "*",
    ]
  }
}

#Role to assume to allow autoscaling
data "aws_iam_policy_document" "spot_fleet_autoscaling_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}
