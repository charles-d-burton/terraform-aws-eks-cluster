#Generate the spot fleet request, loads Userdata to each instance to join it to the cluster
resource "aws_spot_fleet_request" "us_east1_fleet" {
  iam_fleet_role                      = "${aws_iam_role.spot_fleet_role.arn}"
  allocation_strategy                 = "${var.allocation_strategy}"
  target_capacity                     = "${var.fleet_size}"
  valid_until                         = "${var.valid_until}"
  replace_unhealthy_instances         = true
  wait_for_fulfillment                = true
  terminate_instances_with_expiration = true

  //target_groups                       = ["${var.target_groups}"]

  #TODO: Figure this out, relationship to other resources is problem
  lifecycle {
    create_before_destroy = true
  }
  ######################
  #t3.nano
  ######################
  launch_specification {
    instance_type          = "t3.nano"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 0)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "t3.nano"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 1)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "t3.nano"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 2)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  ######################
  #m5.large
  ######################
  launch_specification {
    instance_type          = "m5.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 0)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "m5.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 1)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "m5.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 2)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  ######################
  #c5.large
  ######################
  launch_specification {
    instance_type          = "c5.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 0)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "c5.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 1)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "c5.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 2)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  ######################
  #r4.large
  ######################
  launch_specification {
    instance_type          = "r4.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 0)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "r4.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 1)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  launch_specification {
    instance_type          = "r4.large"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.name}"
    subnet_id              = "${element(var.subnet_ids, 2)}"
    vpc_security_group_ids = ["${var.security_group_id}"]

    ebs_block_device = {
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "true"
      device_name           = "/dev/xvda"
    }

    user_data = "${var.userdata}"

    tags = "${var.tags}"
  }
  depends_on = ["aws_iam_role.spot_instance_role", "aws_iam_role.spot_fleet_role"]
}

/* 
#Cloudwatch autoscaling and monitoring
resource "aws_cloudwatch_metric_alarm" "us_east_1_pa_cluster_cpu_util_cloudwatch" {
  alarm_name          = "${var.cpu_util_metric_name}"
  comparison_operator = "${var.cpu_util_comparison_operator}"
  evaluation_periods  = "${var.cpu_util_evaluation_periods}"
  metric_name         = "${var.cpu_util_metric_name}"
  namespace           = "${var.cpu_util_namespace}"
  period              = "${var.cpu_util_period}"
  statistic           = "${var.cpu_util_statistic}"
  threshold           = "${var.cpu_util_threshold}"
  alarm_actions       = "${var.notification}"

  alarm_description = "CloudWatch metric alarm:  ${var.cpu_util_metric_name} ${var.cpu_util_comparison_operator}"

  dimensions {
    ClusterName = ""
  }
}

resource "aws_cloudwatch_metric_alarm" "us_east_1_pa_cluster_mem_util_cloudwatch" {
  alarm_name          = "${var.memory_util_metric_name}"
  comparison_operator = "${var.memory_util_comparison_operator}"
  evaluation_periods  = "${var.memory_util_evaluation_periods}"
  metric_name         = "${var.memory_util_metric_name}"
  namespace           = "${var.memory_util_namespace}"
  period              = "${var.memory_util_period}"
  statistic           = "${var.memory_util_statistic}"
  threshold           = "${var.memory_util_threshold}"
  alarm_actions       = "${var.notification}"

  alarm_description = "CloudWatch metric alarm:  ${var.memory_util_metric_name} ${var.memory_util_comparison_operator}"

  dimensions {
    ClusterName = ""
  }
}

resource "aws_appautoscaling_target" "us_east_1_service_target" {
  max_capacity = 50
  min_capacity = "${var.fleet_size}"
  resource_id  = "spot-fleet-request/${aws_spot_fleet_request.us_east1_fleet.id}"
  role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/ec2.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_EC2SpotFleetRequest"

  #role_arn           = "${aws_iam_role.autoscaling_role.arn}"  
  #for more see this bug https://github.com/terraform-providers/terraform-provider-aws/issues/240
  scalable_dimension = "ec2:spot-fleet-request:TargetCapacity"

  service_namespace = "ec2"
}

resource "aws_appautoscaling_policy" "us_east_1_service_down_policy" {
  name               = "scale-down "
  resource_id        = "spot-fleet-request/${aws_spot_fleet_request.us_east1_fleet.id}"
  scalable_dimension = "ec2:spot-fleet-request:TargetCapacity"
  service_namespace  = "ec2"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Minimum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -2
    }
  }

  depends_on = ["aws_appautoscaling_target.us_east_1_service_target"]
}

resource "aws_appautoscaling_policy" "us_east_1_service_up_policy" {
  name               = "scale-up "
  resource_id        = "spot-fleet-request/${aws_spot_fleet_request.us_east1_fleet.id}"
  scalable_dimension = "ec2:spot-fleet-request:TargetCapacity"
  service_namespace  = "ec2"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 5
    }
  }

  depends_on = ["aws_appautoscaling_target.us_east_1_service_target"]
}

resource "aws_cloudwatch_metric_alarm" "us_east_1_service_highcpu_scaleup" {
  alarm_name          = "-scaleup"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/pa"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"

  alarm_description = "CPU Autoscaling alarm to scale up"

  dimensions {
    ClusterName = ""
  }

  alarm_actions = [
    "${aws_appautoscaling_policy.us_east_1_service_up_policy.arn}",
  ]

  depends_on = ["aws_appautoscaling_policy.us_east_1_service_up_policy"]
}

resource "aws_cloudwatch_metric_alarm" "us_east_1_service_highcpu_scaledown" {
  alarm_name          = "-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/pa"
  period              = "60"
  statistic           = "Average"
  threshold           = "60"

  alarm_description = "CPU Autoscaling alarm to scale down"

  dimensions {
    ClusterName = ""
  }

  alarm_actions = [
    "${aws_appautoscaling_policy.us_east_1_service_down_policy.arn}",
  ]

  depends_on = ["aws_appautoscaling_policy.us_east_1_service_down_policy"]
} */

