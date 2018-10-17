variable "fleet_size" {}

variable "allocation_strategy" {
  type    = "string"
  default = "diversified"
}

variable "service_name" {
  type = "string"
}

variable "valid_until" {
  default = "2022-11-04T20:44:20Z"
}

variable "ami_id" {
  type = "string"
}

variable "userdata" {
  type = "string"
}

variable "subnet_ids" {
  type    = "list"
  default = []
}

variable "instance_policy_arns" {
  type        = "list"
  default     = []
  description = "List of extra policies to attach to instances"
}

variable "security_group_id" {
  type        = "string"
  description = "SG to attach to instances"
}

variable "tags" {
  type        = "map"
  description = "map of extra tags to assign to instances"
  default     = {}
}

/* variable "target_groups" {
  type    = "list"
  default = []
} */

variable "vpc_id" {}

variable "key_name" {}

variable "region" {}

variable "env" {}

/*
CloudWatch configurations.
*/

variable "cpu_util_metric_name" {
  default = "CPUUtilization"
}

variable "cpu_util_period" {
  default = 60
}

variable "cpu_util_evaluation_periods" {
  default = 2
}

variable "cpu_util_threshold" {
  default = 80
}

variable "cpu_util_namespace" {
  default = "AWS/ECS"
}

variable "cpu_util_comparison_operator" {
  default = "GreaterThanOrEqualToThreshold"
}

variable "cpu_util_statistic" {
  default = "Average"
}

variable "memory_util_metric_name" {
  default = "MemoryUtilization"
}

variable "memory_util_period" {
  default = 60
}

variable "memory_util_evaluation_periods" {
  default = 2
}

variable "memory_util_threshold" {
  default = 80
}

variable "memory_util_namespace" {
  default = "AWS/ECS"
}

variable "memory_util_comparison_operator" {
  default = "GreaterThanOrEqualToThreshold"
}

variable "memory_util_statistic" {
  default = "Average"
}

variable "notification" {
  default = ["arn:aws:sns:us-west-2:1234567890:no-alarm"]
}
